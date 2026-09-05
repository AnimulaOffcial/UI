--!strict
-- performance.lua - anti lag buat animula ui
-- jujur ini gw bikin karena dulu ui gw lag parah kalo kebanyakan tween wkwk
-- jadi sekarang semua di throttle / debounce

local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Performance = {}

-- debounce - tunda eksekusi sampe idle, enak buat canvas update
function Performance.Debounce(fn: () -> (), delay: number?): () -> ()
    local d: number = delay or 0.06
    local thread: thread? = nil
    return function()
        if thread then task.cancel(thread) end
        thread = task.delay(d, function()
            thread = nil
            fn()
        end) :: any
    end
end

-- throttle - batasi biar gak spam, misal slider di drag
function Performance.Throttle(fn: (...any) -> (), interval: number?): (...any) -> ()
    local i: number = interval or 0.016 -- 60fps
    local last: number = 0
    return function(...: any)
        local now: number = os.clock()
        if now - last >= i then
            last = now
            fn(...)
        end
    end
end

-- tween pooling - cancel tween lama kalo objek yg sama di tween lagi
-- ini ngaruh bgt biar gak numpuk tween
local _activeTweens: { [Instance]: Tween } = {}

function Performance.Tween(
    obj: Instance,
    props: { [string]: any },
    time: number?,
    style: Enum.EasingStyle?,
    dir: Enum.EasingDirection?
): Tween
    local old: Tween? = _activeTweens[obj]
    if old then pcall(function() old:Cancel() end) end

    local info = TweenInfo.new(
        time  or 0.20,
        style or Enum.EasingStyle.Quad,
        dir   or Enum.EasingDirection.Out
    )
    local tw: Tween = TweenService:Create(obj, info, props)
    _activeTweens[obj] = tw
    tw.Completed:Connect(function()
        if _activeTweens[obj] == tw then
            _activeTweens[obj] = nil
        end
    end)
    tw:Play()
    return tw
end

function Performance.CancelTween(obj: Instance)
    local tw: Tween? = _activeTweens[obj]
    if tw then pcall(function() tw:Cancel() end) end
    _activeTweens[obj] = nil
end

-- auto canvas tapi di debounce biar gak tiap frame update
function Performance.AutoCanvas(
    frame: ScrollingFrame,
    layout: UIListLayout,
    extraPad: number?
): RBXScriptConnection
    local pad: number = extraPad or 24
    local pending: boolean = false

    local function refresh()
        if pending then return end
        pending = true
        task.defer(function()
            pending = false
            if not frame.Parent then return end
            local sz: Vector2 = layout.AbsoluteContentSize
            local h: number = math.clamp(sz.Y + pad, 0, 9000)
            local w: number = math.clamp(sz.X, 0, 9000)
            frame.CanvasSize = UDim2.fromOffset(w, h)
        end)
    end

    local conn: RBXScriptConnection =
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refresh)
    task.defer(refresh)
    return conn
end

-- connection pool biar gampang cleanup pas window di destroy
export type Pool = {
    Add: (Pool, RBXScriptConnection) -> (),
    Clear: (Pool) -> (),
    _conns: { RBXScriptConnection },
}

function Performance.NewPool(): Pool
    local pool: Pool = { _conns = {} } :: Pool
    function pool:Add(conn: RBXScriptConnection)
        table.insert(self._conns, conn)
    end
    function pool:Clear()
        for _, c: RBXScriptConnection in ipairs(self._conns) do
            pcall(function() c:Disconnect() end)
        end
        table.clear(self._conns)
    end
    return pool
end

-- batasi toast biar gak spam 20 notif numpuk wkwk
Performance.NotifyLimit    = 5
Performance.NotifyDuration = 3

function Performance.EnforceLimit(container: Frame, limit: number?)
    local maxN: number = limit or Performance.NotifyLimit
    local toasts: { Frame } = {}
    for _, ch: Instance in ipairs(container:GetChildren()) do
        if ch:IsA("Frame") and ch.Name ~= "UIListLayout" and ch.Name ~= "UIPadding" then
            table.insert(toasts, ch :: Frame)
        end
    end
    while #toasts > maxN do
        local oldest: Frame? = table.remove(toasts, 1)
        if oldest then oldest:Destroy() end
    end
end

-- lazy pages - cuma page aktif yg visible, sisanya di hide
function Performance.SetPageActive(pages: { Frame }, active: Frame)
    for _, pg: Frame in ipairs(pages) do
        pg.Visible = (pg == active)
    end
    task.defer(function()
        local parent: Instance? = active.Parent
        if parent and parent:IsA("ScrollingFrame") then
            (parent :: ScrollingFrame).CanvasPosition = Vector2.zero
        end
    end)
end

-- heartbeat helper kalo butuh animasi per frame tapi di throttle
function Performance.OnHeartbeat(
    fn: (number) -> (),
    throttleFps: number?
): RBXScriptConnection
    local interval: number = if throttleFps then 1 / throttleFps else 0
    local last: number = 0
    return RunService.Heartbeat:Connect(function(dt: number)
        if interval > 0 then
            last += dt
            if last < interval then return end
            last = 0
        end
        fn(dt)
    end)
end

-- stagger - animasi masuk satu2 biar keren, kayak orion tapi lebih smooth
function Performance.Stagger(frames: { GuiObject }, delay: number?, tweenTime: number?)
    local d: number = delay or 0.04
    local t: number = tweenTime or 0.25
    for i, f: GuiObject in ipairs(frames) do
        f.BackgroundTransparency = 1
        -- cari textlabel di dalem buat fade juga
        task.delay((i - 1) * d, function()
            if not f.Parent then return end
            Performance.Tween(f, { BackgroundTransparency = 0 }, t)
            for _, ch: Instance in ipairs(f:GetDescendants()) do
                if ch:IsA("TextLabel") or ch:IsA("TextButton") then
                    local tb: TextLabel = ch :: any
                    local orig: number = tb.TextTransparency
                    tb.TextTransparency = 1
                    Performance.Tween(tb, { TextTransparency = orig }, t)
                end
            end
        end)
    end
end

return Performance
