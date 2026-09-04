--!strict
-- loaderui - animula ui v2.2 (bundled, rapih)
-- 100% loadstring, tanpa script.Parent - executor: loadstring(game:HttpGet("https://raw.githubusercontent.com/AnimulaOffcial/UI/main/LoaderUI.lua"))()
-- bundle 30+ file ComponentsUI jadi satu, tapi di repo tetep rapih per-folder

local __mods = {}
local function __require(name) return __mods[name] end


-- ===== ComponentsUI/Theme/AnimulaTheme.lua (AnimulaTheme) =====
__mods["AnimulaTheme"] = (function()
-- animula theme - biru hydro archon
-- gw bikin palet ini malem2 sambil dengerin ost fontaine wkwk
-- biru nya ambil dari gaun furina + vision hydro, mantep bgt

local Theme = {}

-- palet utama animula, jangan di ubah sembarangan ya
Theme.Animula = {
    Background    = Color3.fromRGB(13,  20,  38), -- navy paling gelap, buat base
    Surface       = Color3.fromRGB(19,  30,  58), -- card / window
    SurfaceLight  = Color3.fromRGB(26,  42,  78), -- hover state
    SurfaceHover  = Color3.fromRGB(33,  52,  96), -- hover lebih terang

    Primary       = Color3.fromRGB(77,  163, 255), -- biru furina utama
    PrimaryDark   = Color3.fromRGB(42,  119, 217), -- buat gradient bawah
    PrimaryLight  = Color3.fromRGB(120, 188, 255), -- glow
    Secondary     = Color3.fromRGB(91,  202, 255), -- aqua
    Accent        = Color3.fromRGB(155, 214, 255), -- ice blue pucet
    AccentGold    = Color3.fromRGB(214, 196, 135), -- gold trim furina, cakep

    Text          = Color3.fromRGB(235, 245, 255),
    TextDim       = Color3.fromRGB(155, 175, 205),
    TextMuted     = Color3.fromRGB(105, 125, 158),
    TextOnPrimary = Color3.fromRGB(255, 255, 255),

    Border        = Color3.fromRGB(42,  64,  112),
    BorderLight   = Color3.fromRGB(58,  86,  142),
    Shadow        = Color3.fromRGB(0,   0,   0),

    Success       = Color3.fromRGB(74,  222, 128),
    Warning       = Color3.fromRGB(251, 191, 36),
    Error         = Color3.fromRGB(248, 113, 113),
    Info          = Color3.fromRGB(96,  165, 250),

    ToggleOn      = Color3.fromRGB(77,  163, 255),
    ToggleOff     = Color3.fromRGB(38,  52,  80),
    SliderFill    = Color3.fromRGB(77,  163, 255),
    SliderTrack   = Color3.fromRGB(30,  45,  75),

    -- tambahan buat efek keren
    Glow          = Color3.fromRGB(90,  180, 255),
    Wave1         = Color3.fromRGB(77,  163, 255),
    Wave2         = Color3.fromRGB(120, 200, 255),
    GlassBg       = Color3.fromRGB(22,  36,  68),
}

-- varian theme, tadinya cuma dark doang, terus gw nambahin light sama midnight
-- midnight tuh paling gelap, enak buat mata malem2
Theme.Variants = {
    AnimulaDark = Theme.Animula,

    AnimulaLight = {
        Background    = Color3.fromRGB(232, 240, 255),
        Surface       = Color3.fromRGB(245, 248, 255),
        SurfaceLight  = Color3.fromRGB(255, 255, 255),
        SurfaceHover  = Color3.fromRGB(220, 232, 255),
        Primary       = Color3.fromRGB(42,  119, 217),
        PrimaryDark   = Color3.fromRGB(30,  88,  170),
        PrimaryLight  = Color3.fromRGB(77,  163, 255),
        Secondary     = Color3.fromRGB(56,  175, 230),
        Accent        = Color3.fromRGB(77,  163, 255),
        AccentGold    = Color3.fromRGB(168, 148, 90),
        Text          = Color3.fromRGB(18,  30,  55),
        TextDim       = Color3.fromRGB(70,  90,  125),
        TextMuted     = Color3.fromRGB(110, 130, 165),
        TextOnPrimary = Color3.fromRGB(255, 255, 255),
        Border        = Color3.fromRGB(190, 206, 235),
        BorderLight   = Color3.fromRGB(210, 222, 245),
        Shadow        = Color3.fromRGB(0,   0,   0),
        Success       = Color3.fromRGB(34,  158, 80),
        Warning       = Color3.fromRGB(200, 140, 0),
        Error         = Color3.fromRGB(210, 60,  60),
        Info          = Color3.fromRGB(42,  119, 217),
        ToggleOn      = Color3.fromRGB(42,  119, 217),
        ToggleOff     = Color3.fromRGB(200, 212, 232),
        SliderFill    = Color3.fromRGB(42,  119, 217),
        SliderTrack   = Color3.fromRGB(210, 222, 242),
        Glow          = Color3.fromRGB(60,  130, 255),
        Wave1         = Color3.fromRGB(42,  119, 217),
        Wave2         = Color3.fromRGB(90,  180, 255),
        GlassBg       = Color3.fromRGB(235, 242, 255),
    },

    AnimulaMidnight = {
        Background    = Color3.fromRGB(7,   11,  22),
        Surface       = Color3.fromRGB(12,  18,  36),
        SurfaceLight  = Color3.fromRGB(18,  28,  54),
        SurfaceHover  = Color3.fromRGB(24,  38,  70),
        Primary       = Color3.fromRGB(77,  163, 255),
        PrimaryDark   = Color3.fromRGB(42,  119, 217),
        PrimaryLight  = Color3.fromRGB(120, 188, 255),
        Secondary     = Color3.fromRGB(91,  202, 255),
        Accent        = Color3.fromRGB(155, 214, 255),
        AccentGold    = Color3.fromRGB(214, 196, 135),
        Text          = Color3.fromRGB(235, 245, 255),
        TextDim       = Color3.fromRGB(145, 165, 195),
        TextMuted     = Color3.fromRGB(95,  115, 148),
        TextOnPrimary = Color3.fromRGB(255, 255, 255),
        Border        = Color3.fromRGB(28,  44,  82),
        BorderLight   = Color3.fromRGB(40,  60,  108),
        Shadow        = Color3.fromRGB(0,   0,   0),
        Success       = Color3.fromRGB(74,  222, 128),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96,  165, 250),
        ToggleOn      = Color3.fromRGB(77,  163, 255),
        ToggleOff     = Color3.fromRGB(26,  36,  60),
        SliderFill    = Color3.fromRGB(77,  163, 255),
        SliderTrack   = Color3.fromRGB(20,  30,  55),
        Glow          = Color3.fromRGB(90,  180, 255),
        Wave1         = Color3.fromRGB(77,  163, 255),
        Wave2         = Color3.fromRGB(60,  120, 200),
        GlassBg       = Color3.fromRGB(14,  22,  42),
    },
}

-- buat backward compat aja, mungkin ada yg masih pake nama lama
Theme.Variants.AnimulaDark     = Theme.Variants.AnimulaDark
Theme.Variants.AnimulaLight    = Theme.Variants.AnimulaLight
Theme.Variants.AnimulaMidnight = Theme.Variants.AnimulaMidnight
Theme.Animula = Theme.Animula

Theme.Radius = {
    Small  = UDim.new(0,  6),
    Medium = UDim.new(0, 10),
    Large  = UDim.new(0, 14),
    Pill   = UDim.new(1,  0),
    Window = UDim.new(0, 16),
    Card   = UDim.new(0, 12),
}

Theme.Font = {
    Title   = Font.fromEnum(Enum.Font.GothamBold),
    Heading = Font.fromEnum(Enum.Font.GothamSemibold),
    Body    = Font.fromEnum(Enum.Font.Gotham),
    Mono    = Font.fromEnum(Enum.Font.Code),
}

Theme.TextSize = {
    Title   = 18,
    Heading = 14,
    Body    = 13,
    Small   = 11,
    Tiny    = 10,
}

-- ini yg aktif skrg
Theme.CurrentName = "AnimulaDark"
Theme.Current     = Theme.Animula

function Theme:SetVariant(name: string)
    local v = Theme.Variants[name]
    if v then
        Theme.CurrentName = name
        Theme.Current     = v
    else
        warn("[AnimulaTheme] gak nemu variant: " .. tostring(name))
    end
    return Theme.Current
end

function Theme:Get(key: string?): Color3
    if not key then return Theme.Current.Primary end
    return (Theme.Current :: any)[key] or Theme.Current.Primary
end

-- helper buat dapet warna dengan alpha (transparansi palsu)
function Theme:Alpha(key: string, alpha: number): Color3
    -- roblox gak ada alpha di Color3, jadi kita blend ke background
    local c = self:Get(key)
    local bg = self.Current.Background
    return Color3.new(
        c.R * alpha + bg.R * (1 - alpha),
        c.G * alpha + bg.G * (1 - alpha),
        c.B * alpha + bg.B * (1 - alpha)
    )
end

return Theme
end)()

-- ===== ComponentsUI/Core/Config.lua (Config) =====
__mods["Config"] = (function()
-- config / flags buat animula ui
-- konsep nya kayak orion: tiap element punya Flag, terus bisa di akses via Flags[flag].Value
-- gw tambahin save/load ke file juga biar gak ilang pas rejoin

local Config = {}

local _flags:     { [string]: any }         = {}
local _callbacks: { [string]: (any) -> () } = {}
local _elements:  { [string]: any }         = {} -- ref ke element object nya

function Config:SetFlag(flag: string, value: any)
    _flags[flag] = value
    local el = _elements[flag]
    if el then
        (el :: any).Value = value
    end
    local cb = _callbacks[flag]
    if cb then task.spawn(cb, value) end
end

function Config:GetFlag(flag: string, default: any?): any
    local v = _flags[flag]
    if v == nil then return default end
    return v
end

function Config:OnChanged(flag: string, cb: (any) -> ())
    _callbacks[flag] = cb
end

function Config:Register(flag: string, element: any)
    _elements[flag] = element
end

-- ini yg dipake di luar: AnimulaUI.Flags["myFlag"].Value
Config.Flags = {} :: { [string]: { Value: any } }

setmetatable(Config.Flags, {
    __index = function(_, key: string)
        local v = _flags[key]
        if v ~= nil then
            return { Value = v }
        end
        return nil
    end,
    __newindex = function(_, key: string, val: any)
        local value = if typeof(val) == "table" and (val :: any).Value ~= nil
            then (val :: any).Value
            else val
        Config:SetFlag(key, value)
    end,
})

-- save/load ke file (cuma jalan di executor yg support writefile)
function Config:SaveToFile(folder: string, fileName: string)
    local ok = pcall(function()
        if not isfolder(folder) then makefolder(folder) end
        writefile(folder .. "/" .. fileName .. ".json",
            game:GetService("HttpService"):JSONEncode(_flags))
    end)
    return ok
end

function Config:LoadFromFile(folder: string, fileName: string): boolean
    local ok, result = pcall(function()
        local raw = readfile(folder .. "/" .. fileName .. ".json")
        return game:GetService("HttpService"):JSONDecode(raw)
    end)
    if ok and typeof(result) == "table" then
        for k, v in pairs(result :: any) do
            Config:SetFlag(k, v)
        end
        return true
    end
    return false
end

-- buat debug aja
Config._raw = _flags

return Config
end)()

-- ===== ComponentsUI/Core/Performance.lua (Performance) =====
__mods["Performance"] = (function()
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
end)()

-- ===== ComponentsUI/Core/Utils.lua (Utils) =====
__mods["Utils"] = (function()
-- utils buat animula ui
-- isinya helper2 kecil yg kepake dimana2
-- tadinya mau dipisah file lagi tapi yaudah taro sini aja biar gampang

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Players          = game:GetService("Players")

local Utils = {}

-- dapetin parent gui yg bener
-- kalo pake executor biasanya ada gethui, kalo di studio pake CoreGui / PlayerGui
function Utils.getHui(): Instance
    local ok, hui = pcall(function() return (gethui :: any) and gethui() end)
    if ok and typeof(hui) == "Instance" then
        return hui
    end

    if RunService:IsStudio() then
        local ok2, cg = pcall(function() return game:GetService("CoreGui") end)
        if ok2 and cg then return cg end
    end

    local lp = Players.LocalPlayer
    if lp then
        local pg = lp:FindFirstChildOfClass("PlayerGui")
        if pg then return pg end
    end

    return workspace :: any
end

-- bikin corner rounding
function Utils.Corner(parent: Instance, radius: UDim): UICorner
    local c = Instance.new("UICorner")
    c.CornerRadius = radius
    c.Parent       = parent
    return c
end

-- stroke / border luar
function Utils.Stroke(
    parent: Instance,
    color: Color3,
    thickness: number?,
    transparency: number?
): UIStroke
    local s = Instance.new("UIStroke")
    s.Color           = color
    s.Thickness       = thickness or 1
    s.Transparency    = transparency or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent          = parent
    return s
end

-- padding, biar gak sesek
function Utils.Padding(
    parent: Instance,
    left: number,
    top: number,
    right: number,
    bottom: number
): UIPadding
    local p = Instance.new("UIPadding")
    p.PaddingLeft   = UDim.new(0, left)
    p.PaddingTop    = UDim.new(0, top)
    p.PaddingRight  = UDim.new(0, right)
    p.PaddingBottom = UDim.new(0, bottom)
    p.Parent        = parent
    return p
end

-- gradient 2 warna
function Utils.Gradient(
    parent: Instance,
    c1: Color3,
    c2: Color3,
    rotation: number?
): UIGradient
    local g = Instance.new("UIGradient")
    g.Color    = ColorSequence.new(c1, c2)
    g.Rotation = rotation or 90
    g.Parent   = parent
    return g
end

-- gradient 3 warna (buat wave / accent bar yg lebih cakep)
function Utils.Gradient3(
    parent: Instance,
    c1: Color3,
    c2: Color3,
    c3: Color3,
    rotation: number?
): UIGradient
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   c1),
        ColorSequenceKeypoint.new(0.5, c2),
        ColorSequenceKeypoint.new(1,   c3),
    })
    g.Rotation = rotation or 90
    g.Parent   = parent
    return g
end

-- tween, tapi lewat Performance biar gak lag kalo spam
function Utils.Tween(
    obj: Instance,
    props: { [string]: any },
    time: number?,
    style: Enum.EasingStyle?,
    dir: Enum.EasingDirection?
): Tween
    local Perf: any = nil
    local ok = pcall(function()
        Perf = __require("Performance")
    end)
    if ok and Perf then
        return Perf.Tween(obj, props, time, style, dir)
    end
    local info = TweenInfo.new(
        time  or 0.22,
        style or Enum.EasingStyle.Quad,
        dir   or Enum.EasingDirection.Out
    )
    local tw = TweenService:Create(obj, info, props)
    tw:Play()
    return tw
end

-- bikin frame bisa di drag
-- simple aja, gak perlu ribet
function Utils.MakeDraggable(dragHandle: GuiObject, target: GuiObject)
    local dragging  = false
    local dragStart = Vector2.zero
    local startPos  = target.Position

    dragHandle.InputBegan:Connect(function(input: InputObject)
        local isMouse = input.UserInputType == Enum.UserInputType.MouseButton1
        local isTouch = input.UserInputType == Enum.UserInputType.Touch
        if isMouse or isTouch then
            dragging  = true
            dragStart = Vector2.new(input.Position.X, input.Position.Y)
            startPos  = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input: InputObject)
        local isMove  = input.UserInputType == Enum.UserInputType.MouseMovement
        local isTouch = input.UserInputType == Enum.UserInputType.Touch
        if dragging and (isMove or isTouch) then
            local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- clamp & round helper
function Utils.Clamp(n: number, lo: number, hi: number): number
    return math.clamp(n, lo, hi)
end

function Utils.Round(n: number, step: number): number
    if step <= 0 then return n end
    return math.round(n / step) * step
end

-- bikin shadow simple (frame offset di belakang)
function Utils.Shadow(parent: GuiObject, color: Color3?, transparency: number?): Frame
    local s = Instance.new("Frame")
    s.Name                   = "Shadow"
    s.BackgroundColor3       = color or Color3.new(0, 0, 0)
    s.BackgroundTransparency = transparency or 0.7
    s.Size                   = UDim2.new(1, 10, 1, 10)
    s.Position               = UDim2.fromOffset(-5, -5)
    s.ZIndex                 = parent.ZIndex - 1
    s.BorderSizePixel        = 0
    s.Parent                 = parent
    -- corner nya ngikut parent kalo ada
    local pc = parent:FindFirstChildOfClass("UICorner")
    if pc then
        local sc = Instance.new("UICorner")
        sc.CornerRadius = pc.CornerRadius
        sc.Parent       = s
    end
    return s
end

-- ripple effect pas klik (buat button biar hidup)
function Utils.Ripple(btn: GuiObject, color: Color3?)
    local c = color or Color3.fromRGB(255, 255, 255)
    btn.ClipsDescendants = true
    btn.InputBegan:Connect(function(input: InputObject)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        local ripple = Instance.new("Frame")
        ripple.BackgroundColor3       = c
        ripple.BackgroundTransparency = 0.7
        ripple.AnchorPoint            = Vector2.new(0.5, 0.5)
        ripple.Position               = UDim2.fromOffset(input.Position.X - btn.AbsolutePosition.X, input.Position.Y - btn.AbsolutePosition.Y)
        ripple.Size                   = UDim2.fromOffset(0, 0)
        ripple.ZIndex                 = btn.ZIndex + 1
        ripple.Parent                 = btn
        local cr = Instance.new("UICorner")
        cr.CornerRadius = UDim.new(1, 0)
        cr.Parent       = ripple
        local tw = TweenService:Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size                   = UDim2.fromOffset(300, 300),
            BackgroundTransparency = 1,
        })
        tw:Play()
        tw.Completed:Connect(function() ripple:Destroy() end)
    end)
end

return Utils
end)()

-- ===== ComponentsUI/Core/Responsive.lua (Responsive) =====
__mods["Responsive"] = (function()
-- responsive.lua - biar animula ui cakep di semua device
-- riset: roblox vs html beda jauh soal ukuran
-- html pake px/rem/vw, roblox pake UDim2 (Scale + Offset) + TextSize pixel
-- jadi gw bikin helper biar window auto nyesuain viewport

--[[

  CATATAN RISET - baca dulu sebelum edit!

  1. Roblox TextSize vs HTML font-size
     - Roblox TextSize = pixel absolut, kayak html px tapi gak scale sama viewport
     - html 16px = TextSize 16 di roblox, 1:1 di 1x DPI
     - tapi di layar 4K, 16px roblox keliatan kecil (0.4% width) vs 1080p (0.8%)
     - solusi: jangan pake TextScaled=true buat UI util (bikin lag, re-render tiap frame)
       pake TextSize fixed + UITextSizeConstraint kalo mau responsif
     - di animula kita pake: Title 18, Heading 14, Body 13, Small 11, Tiny 10
       ini udah pas, jangan di bawah 9 (gak kebaca)

  2. Roblox Size vs HTML size
     - html: width: 640px  atau  50%  atau  50vw
     - roblox: UDim2.new(ScaleX, OffsetX, ScaleY, OffsetY)
       AbsoluteSize.X = Parent.AbsoluteSize.X * Scale + Offset
     - Offset doang (fromOffset 640,430) = pixel perfect di 1080p tapi pecah di HP
       640px di iPhone SE (375px logic) = 170% layar wkwk full penuh
     - Scale doang (fromScale 0.6,0.7) = responsif tapi di ultrawide jadi kegedean
     - Hybrid + UIScale + UISizeConstraint = paling aman (kita pake ini)

  3. Ukuran window ideal (riset dari orion/fluent/rayfield)
     - Orion/Fluent: 550-600 x 380-450
     - Rayfield: 500 x 400
     - Animula awal 640x430 kegedean dikit buat HP, jadi kita ganti 600x400
       + clamp Min 480x320 Max 700x500 biar gak pecah
     - di HP < 600px, sidebar 168px + content 1,-184 = content cuma 207px sisa, sempit
       jadi di HP kita collapse sidebar jadi drawer (tombol hamburger)

  4. HTML vs Roblox unit
     - html px         -> roblox Offset + TextSize (1:1 di 1x DPI)
     - html %          -> roblox Scale (0.5 = 50%)
     - html vw/vh      -> roblox Scale di ScreenGui (1 = 100vw)
     - html rem        -> gak ada di roblox, simulasi pake UIScale = vp.X / 1920
     - html border-radius 8px -> roblox UICorner UDim.new(0,8), pill = UDim.new(1,0)

  5. TweenService - jangan spam!
     - tiap Tween = objek GC, spam 20 tween/detik = lag
     - durasi hover 0.18-0.25s, entrance 0.3-0.35s Back Out, jangan >0.5s kelamaan
     - selalu cancel tween lama sebelum bikin baru (kita udah ada Performance.Tween pooling)
     - jangan tween UIStroke.Thickness di text (bikin regenerate glyph)

--]]

local Theme = __require("AnimulaTheme")

local Responsive = {}

-- deteksi device berdasarkan viewport
export type Device = "Phone" | "Tablet" | "Desktop"

function Responsive.GetDevice(viewport: Vector2?): Device
    local vp: Vector2 = viewport or workspace.CurrentCamera.ViewportSize
    if vp.X < 600 then
        return "Phone"
    elseif vp.X < 1024 then
        return "Tablet"
    else
        return "Desktop"
    end
end

-- kasih tau ukuran window yg ideal buat device itu
function Responsive.GetWindowSize(device: Device?): UDim2
    local d: Device = device or Responsive.GetDevice()
    if d == "Phone" then
        -- di HP pake scale biar gak kepotong
        return UDim2.fromScale(0.92, 0.84)
    elseif d == "Tablet" then
        return UDim2.fromScale(0.76, 0.72)
    else
        return UDim2.fromOffset(600, 400) -- desktop sweet spot
    end
end

-- pasang UISizeConstraint biar window gak kegedean / kekecilan
function Responsive.AttachConstraints(frame: GuiObject)
    -- hapus yg lama kalo ada (biar gak dobel)
    for _, ch: Instance in ipairs(frame:GetChildren()) do
        if ch:IsA("UISizeConstraint") and ch.Name == "Animula_Constraint" then
            ch:Destroy()
        end
        if ch:IsA("UIAspectRatioConstraint") and ch.Name == "Animula_Aspect" then
            ch:Destroy()
        end
    end

    local sc = Instance.new("UISizeConstraint")
    sc.Name    = "Animula_Constraint"
    sc.MinSize = Vector2.new(480, 320) -- HP tetep usable
    sc.MaxSize = Vector2.new(700, 500) -- PC jangan 1000+ ntar aneh
    sc.Parent  = frame

    -- aspect ratio biar proporsional, optional tapi cakep
    local ar = Instance.new("UIAspectRatioConstraint")
    ar.Name         = "Animula_Aspect"
    ar.AspectRatio  = 1.50 -- 600/400
    ar.DominantAxis = Enum.DominantAxis.Width
    ar.AspectType   = Enum.AspectType.FitWithinMaxSize
    ar.Parent       = frame

    return sc, ar
end

-- UIScale biar text tetep proporsional di DPI beda
-- html rem = root font, di roblox kita fake pake ini
function Responsive.AttachScale(gui: ScreenGui | Frame): UIScale
    local scale = Instance.new("UIScale")
    scale.Name   = "Animula_Scale"
    scale.Parent = gui

    local cam: Camera? = workspace.CurrentCamera
    local function update()
        local vp: Vector2 = cam and cam.ViewportSize or Vector2.new(1920, 1080)
        -- 1920 = baseline desktop, clamp 0.65 - 1.0
        local s: number = math.clamp(vp.X / 1920, 0.65, 1.0)
        -- di HP jangan terlalu kecil, minimal 0.78 biar text kebaca
        if vp.X < 600 then
            s = math.clamp(vp.X / 375 * 0.88, 0.78, 0.92)
        end
        scale.Scale = s
    end

    update()
    if cam then
        cam:GetPropertyChangedSignal("ViewportSize"):Connect(update)
    end

    return scale
end

-- collapse sidebar kalo di HP (biar content gak sempit)
function Responsive.ShouldCollapseSidebar(viewport: Vector2?): boolean
    local vp: Vector2 = viewport or workspace.CurrentCamera.ViewportSize
    return vp.X < 600
end

-- text size token - kayak css variables
-- biar konsisten, jangan hardcode angka random
function Responsive.TextSize(token: string): number
    -- token: "title" | "heading" | "body" | "small" | "tiny"
    local map: { [string]: number } = {
        title   = Theme.TextSize.Title,   -- 18
        heading = Theme.TextSize.Heading, -- 14
        body    = Theme.TextSize.Body,    -- 13
        small   = Theme.TextSize.Small,   -- 11
        tiny    = Theme.TextSize.Tiny,    -- 10
    }
    return map[string.lower(token)] or Theme.TextSize.Body
end

-- helper buat bikin label yg auto-resize (kayak html word-wrap)
function Responsive.MakeAutoLabel(
    parent: Instance,
    text: string,
    token: string?,
    color: Color3?
): TextLabel
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Size                   = UDim2.new(1, 0, 0, 0)
    lbl.AutomaticSize          = Enum.AutomaticSize.Y
    lbl.FontFace               = Theme.Font.Body
    lbl.TextSize               = Responsive.TextSize(token or "body")
    lbl.TextColor3             = color or Theme.Current.Text
    lbl.TextXAlignment         = Enum.TextXAlignment.Left
    lbl.TextWrapped            = true
    lbl.Text                   = text
    lbl.Parent                 = parent
    return lbl
end

return Responsive
end)()

-- ===== ComponentsUI/Effects/OceanEffects.lua (OceanEffects) =====
__mods["OceanEffects"] = (function()
-- ocean effects - biar animula ui keliatan hidup
-- ada wave, shimmer, glow, glass, particle bubble
-- semua efek ringan ya, gak bikin lag

local Theme       = __require("AnimulaTheme")
local Performance = __require("Performance")
local Utils       = __require("Utils")

local OceanEffects = {}

-- shimmer sweep - garis kilau jalan dari kiri ke kanan
-- cakep buat accent bar / button
function OceanEffects.Shimmer(frame: GuiObject, color: Color3?, duration: number?)
    local c: Color3 = color or Color3.new(1, 1, 1)
    local d: number = duration or 1.8

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(0.5, c),
        ColorSequenceKeypoint.new(1,   Color3.new(1, 1, 1)),
    })
    grad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,   1),
        NumberSequenceKeypoint.new(0.4, 0.6),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.6, 0.6),
        NumberSequenceKeypoint.new(1,   1),
    })
    grad.Offset = Vector2.new(-1, 0)
    grad.Rotation = 15
    grad.Parent = frame

    -- animasi loop
    task.spawn(function()
        while grad.Parent do
            local tw = Performance.Tween(grad, { Offset = Vector2.new(1, 0) }, d, Enum.EasingStyle.Linear)
            tw.Completed:Wait()
            if not grad.Parent then break end
            grad.Offset = Vector2.new(-1, 0)
            task.wait(1.2)
        end
    end)

    return grad
end

-- wave di background - gradient yg gerak pelan
function OceanEffects.Wave(frame: GuiObject)
    local T = Theme.Current

    local wave = Instance.new("Frame")
    wave.Name                   = "WaveLayer"
    wave.BackgroundColor3       = T.Primary
    wave.BackgroundTransparency = 0.88
    wave.Size                   = UDim2.fromScale(1, 1)
    wave.BorderSizePixel        = 0
    wave.ZIndex                 = frame.ZIndex
    wave.Parent                 = frame

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new(
        T.Wave1,
        T.Wave2
    )
    grad.Rotation = 25
    grad.Offset   = Vector2.new(0, 0)
    grad.Parent   = wave

    -- corner ngikut parent
    local pc = frame:FindFirstChildOfClass("UICorner")
    if pc then
        local sc = Instance.new("UICorner")
        sc.CornerRadius = pc.CornerRadius
        sc.Parent       = wave
    end

    -- gerak pelan biar kayak ombak
    task.spawn(function()
        local dir = 1
        while grad.Parent do
            local target = if dir == 1 then Vector2.new(0.15, 0) else Vector2.new(-0.15, 0)
            local tw = Performance.Tween(grad, { Offset = target }, 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            tw.Completed:Wait()
            if not grad.Parent then break end
            dir *= -1
        end
    end)

    return wave
end

-- glow di belakang frame - biar kayak bercahaya
function OceanEffects.Glow(parent: GuiObject, color: Color3?, size: number?)
    local T = Theme.Current
    local c: Color3 = color or T.Glow
    local sz: number = size or 20

    local glow = Instance.new("ImageLabel")
    glow.Name                   = "GlowFX"
    glow.BackgroundTransparency = 1
    glow.Image                  = "rbxassetid://5028857084" -- circle
    glow.ImageColor3            = c
    glow.ImageTransparency      = 0.7
    glow.ScaleType              = Enum.ScaleType.Slice
    glow.SliceCenter            = Rect.new(24, 24, 276, 276)
    glow.Size                   = UDim2.new(1, sz, 1, sz)
    glow.Position               = UDim2.fromOffset(-sz/2, -sz/2)
    glow.ZIndex                 = parent.ZIndex - 1
    glow.Parent                 = parent

    -- pulse pelan
    task.spawn(function()
        while glow.Parent do
            Performance.Tween(glow, { ImageTransparency = 0.85 }, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
            if not glow.Parent then break end
            Performance.Tween(glow, { ImageTransparency = 0.6 }, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
        end
    end)

    return glow
end

-- glassmorphism - kaca blur palsu (transparansi + stroke tipis)
-- di roblox gak bisa blur beneran jadi kita fake aja pake transparansi
function OceanEffects.Glass(frame: GuiObject, opacity: number?)
    local T = Theme.Current
    local o: number = opacity or 0.12

    frame.BackgroundColor3       = T.GlassBg
    frame.BackgroundTransparency = 1 - o

    local stroke: UIStroke? = frame:FindFirstChildOfClass("UIStroke") :: any
    if not stroke then
        stroke = Utils.Stroke(frame, T.BorderLight, 1, 0.6)
    else
        stroke.Color       = T.BorderLight
        stroke.Transparency = 0.6
    end

    return stroke
end

-- bubble particles - gelembung naik ke atas, cakep buat background
-- anti lag: cuma 6 bubble, recycle
function OceanEffects.Bubbles(container: GuiObject, count: number?)
    local n: number = count or 6
    local bubbles: { Frame } = {}

    for i = 1, n do
        local b = Instance.new("Frame")
        b.Name                   = "Bubble" .. tostring(i)
        b.BackgroundColor3       = Color3.new(1, 1, 1)
        b.BackgroundTransparency = 0.75
        b.Size                   = UDim2.fromOffset(math.random(4, 10), math.random(4, 10))
        b.Position               = UDim2.new(math.random(), 0, 1, math.random(-20, 20))
        b.BorderSizePixel        = 0
        b.ZIndex                 = container.ZIndex + 1
        b.Parent                 = container
        local cr = Instance.new("UICorner")
        cr.CornerRadius = UDim.new(1, 0)
        cr.Parent       = b
        local str = Instance.new("UIStroke")
        str.Color       = Color3.fromRGB(155, 214, 255)
        str.Thickness   = 1
        str.Transparency = 0.5
        str.Parent      = b
        table.insert(bubbles, b)

        -- animasi naik
        local function float()
            if not b.Parent then return end
            local startX = math.random()
            b.Position = UDim2.new(startX, 0, 1, 10)
            local endY = UDim2.new(startX + (math.random() - 0.5) * 0.1, 0, 0, -10)
            local dur: number = math.random(4, 8)
            Performance.Tween(b, { Position = endY }, dur, Enum.EasingStyle.Linear).Completed:Connect(function()
                if b.Parent then
                    task.wait(math.random() * 0.8)
                    float()
                end
            end)
        end
        task.delay(math.random() * 2, float)
    end

    return bubbles
end

-- progress bar hydro - bar yg ada shimmer di dalem
function OceanEffects.ProgressBar(parent: Instance, width: number?, height: number?): (Frame, Frame)
    local T = Theme.Current

    local track = Instance.new("Frame")
    track.Name              = "ProgressTrack"
    track.BackgroundColor3  = T.SliderTrack
    track.Size              = UDim2.new(0, width or 200, 0, height or 6)
    track.BorderSizePixel   = 0
    track.Parent            = parent
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent       = track

    local fill = Instance.new("Frame")
    fill.Name             = "ProgressFill"
    fill.BackgroundColor3 = T.Primary
    fill.Size             = UDim2.new(0, 0, 1, 0)
    fill.BorderSizePixel  = 0
    fill.Parent           = track
    local fc = Instance.new("UICorner")
    fc.CornerRadius = UDim.new(1, 0)
    fc.Parent       = fill
    Utils.Gradient(fill, T.Primary, T.Secondary, 0)
    OceanEffects.Shimmer(fill, Color3.new(1, 1, 1), 1.4)

    return track, fill
end

-- card hover glow - pas mouse masuk, border nyala
function OceanEffects.CardHover(card: GuiObject)
    local T = Theme.Current
    local stroke: UIStroke? = card:FindFirstChildOfClass("UIStroke") :: any
    if not stroke then return end

    local origColor = stroke.Color
    local origTrans = stroke.Transparency

    card.MouseEnter:Connect(function()
        Performance.Tween(stroke :: UIStroke, { Color = T.PrimaryLight, Transparency = 0.2 }, 0.18)
        Performance.Tween(card, { BackgroundColor3 = T.SurfaceHover }, 0.18)
    end)
    card.MouseLeave:Connect(function()
        Performance.Tween(stroke :: UIStroke, { Color = origColor, Transparency = origTrans }, 0.18)
        Performance.Tween(card, { BackgroundColor3 = T.Surface }, 0.18)
    end)
end

return OceanEffects
end)()

-- ===== ComponentsUI/Animations/Motion.lua (Motion) =====
__mods["Motion"] = (function()
-- motion.lua - animasi buat animula ui
-- gw bikin biar ui nya gak kaku, ada spring, slide, fade, scale
-- inspirasinya dari framer motion tapi versi roblox wkwk

local Performance = __require("Performance")

local Motion = {}

-- spring - kayak pegas, enak buat popup / tab switch
function Motion.Spring(obj: Instance, props: { [string]: any }, damping: number?, speed: number?)
    -- di roblox gak ada spring beneran, jadi kita fake pake Back easing
    local s: number = speed or 0.35
    return Performance.Tween(obj, props, s, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

-- slide in dari samping
function Motion.SlideIn(frame: GuiObject, from: string?, time: number?)
    local t: number = time or 0.3
    local origPos: UDim2 = frame.Position
    local dir: string = from or "left"

    local offset: UDim2
    if dir == "left" then
        offset = UDim2.new(origPos.X.Scale, origPos.X.Offset - 40, origPos.Y.Scale, origPos.Y.Offset)
    elseif dir == "right" then
        offset = UDim2.new(origPos.X.Scale, origPos.X.Offset + 40, origPos.Y.Scale, origPos.Y.Offset)
    elseif dir == "top" then
        offset = UDim2.new(origPos.X.Scale, origPos.X.Offset, origPos.Y.Scale, origPos.Y.Offset - 30)
    else
        offset = UDim2.new(origPos.X.Scale, origPos.X.Offset, origPos.Y.Scale, origPos.Y.Offset + 30)
    end

    frame.Position               = offset
    frame.BackgroundTransparency = 0.3
    Performance.Tween(frame, { Position = origPos, BackgroundTransparency = 0 }, t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    -- fade text juga
    for _, ch: Instance in ipairs(frame:GetDescendants()) do
        if ch:IsA("TextLabel") or ch:IsA("TextButton") then
            local lbl: TextLabel = ch :: any
            local ot: number = lbl.TextTransparency
            lbl.TextTransparency = 1
            Performance.Tween(lbl, { TextTransparency = ot }, t + 0.08)
        end
    end
end

-- fade in
function Motion.FadeIn(obj: GuiObject, time: number?)
    local t: number = time or 0.22
    obj.BackgroundTransparency = 1
    Performance.Tween(obj, { BackgroundTransparency = 0 }, t)
    for _, ch: Instance in ipairs(obj:GetDescendants()) do
        if ch:IsA("TextLabel") or ch:IsA("TextButton") or ch:IsA("TextBox") then
            local lbl: any = ch
            local ot: number = lbl.TextTransparency
            lbl.TextTransparency = 1
            Performance.Tween(lbl, { TextTransparency = ot }, t)
        end
        if ch:IsA("ImageLabel") then
            local img: ImageLabel = ch :: any
            local oi: number = img.ImageTransparency
            img.ImageTransparency = 1
            Performance.Tween(img, { ImageTransparency = oi }, t)
        end
    end
end

-- scale pop - dari kecil ke gede, buat dialog / popup
function Motion.Pop(frame: GuiObject, time: number?)
    local t: number = time or 0.32
    local origSize: UDim2 = frame.Size
    frame.Size = UDim2.new(origSize.X.Scale, origSize.X.Offset - 20, origSize.Y.Scale, origSize.Y.Offset - 20)
    frame.BackgroundTransparency = 0.4
    Performance.Tween(frame, { Size = origSize, BackgroundTransparency = 0 }, t, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

-- tab switch - slide + fade, biar pindah tab gak boring
function Motion.TabSwitch(oldPage: Frame?, newPage: Frame)
    if oldPage and oldPage.Parent then
        -- old geser kiri + fade
        Performance.Tween(oldPage, { Position = UDim2.new(0, -18, 0, 0) }, 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.delay(0.14, function()
            if oldPage.Parent then oldPage.Visible = false end
            oldPage.Position = UDim2.fromOffset(0, 0)
        end)
    end

    newPage.Visible  = true
    newPage.Position = UDim2.new(0, 18, 0, 0)
    -- cari background transparency awal
    local ot: number = 0
    pcall(function() ot = (newPage :: any).BackgroundTransparency end)
    Performance.Tween(newPage, { Position = UDim2.fromOffset(0, 0) }, 0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    -- stagger child nya
    local kids: { GuiObject } = {}
    for _, ch: Instance in ipairs(newPage:GetChildren()) do
        if ch:IsA("GuiObject") then table.insert(kids, ch :: GuiObject) end
    end
    Performance.Stagger(kids, 0.03, 0.2)
end

-- button press - mengecil dikit pas di klik
function Motion.Press(btn: GuiObject)
    btn.InputBegan:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Performance.Tween(btn, { Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset - 2, btn.Size.Y.Scale, btn.Size.Y.Offset - 1) }, 0.08)
        end
    end)
    btn.InputEnded:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Performance.Tween(btn, { Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset + 2, btn.Size.Y.Scale, btn.Size.Y.Offset + 1) }, 0.14, Enum.EasingStyle.Back)
        end
    end)
end

-- shake - buat error / warning
function Motion.Shake(frame: GuiObject)
    local orig: UDim2 = frame.Position
    for i = 1, 4 do
        local off: number = if i % 2 == 0 then 6 else -6
        Performance.Tween(frame, { Position = UDim2.new(orig.X.Scale, orig.X.Offset + off, orig.Y.Scale, orig.Y.Offset) }, 0.06).Completed:Wait()
    end
    Performance.Tween(frame, { Position = orig }, 0.08)
end

-- pulse - kedip pelan, buat notif penting
function Motion.Pulse(frame: GuiObject, color: Color3?, times: number?)
    local n: number = times or 2
    local orig: Color3 = frame.BackgroundColor3
    local c: Color3 = color or Color3.fromRGB(77, 163, 255)
    for _ = 1, n do
        Performance.Tween(frame, { BackgroundColor3 = c }, 0.2).Completed:Wait()
        if not frame.Parent then break end
        Performance.Tween(frame, { BackgroundColor3 = orig }, 0.2).Completed:Wait()
        if not frame.Parent then break end
    end
end

-- typewriter - text muncul satu2 kayak ngetik
function Motion.Typewriter(label: TextLabel, fullText: string, speed: number?)
    local s: number = speed or 0.02
    label.Text = ""
    for i = 1, #fullText do
        if not label.Parent then break end
        label.Text = string.sub(fullText, 1, i)
        task.wait(s)
    end
end

-- count up - angka jalan dari 0 ke target, cakep buat stat
function Motion.CountUp(label: TextLabel, from: number, to: number, duration: number?, suffix: string?)
    local d: number = duration or 0.8
    local suf: string = suffix or ""
    local steps: number = 20
    local stepTime: number = d / steps
    for i = 1, steps do
        if not label.Parent then break end
        local v: number = math.floor(from + (to - from) * (i / steps))
        label.Text = tostring(v) .. suf
        task.wait(stepTime)
    end
    if label.Parent then label.Text = tostring(to) .. suf end
end

return Motion
end)()

-- ===== ComponentsUI/Elements/Index.lua (ElementsIndex) =====
__mods["ElementsIndex"] = (function()
-- elements index - daftar element yg ada di animula ui
-- sebenernya logic nya di TabManager.lua, disini cuma dokumentasi biar gak lupa

local Index = {}

Index.Available = {
    "AddButton      - Tab:AddButton({ Name, Callback })",
    "AddToggle      - Tab:AddToggle({ Name, Default, Flag, Save, Callback })",
    "AddSlider      - Tab:AddSlider({ Name, Min, Max, Default, Increment, ValueName, Callback })",
    "AddDropdown    - Tab:AddDropdown({ Name, Default, Options, Callback }) + Refresh/Set",
    "AddTextbox     - Tab:AddTextbox({ Name, Default, TextDisappear, Callback })",
    "AddBind        - Tab:AddBind({ Name, Default, Hold, Callback }) - keybind",
    "AddColorpicker - Tab:AddColorpicker({ Name, Default, Callback })",
    "AddLabel       - Tab:AddLabel('text')",
    "AddParagraph   - Tab:AddParagraph('Title','Content')",
    "AddSection     - Tab:AddSection({ Name })",
    "AddDivider     - Tab:AddDivider('optional text')",
}

-- tambahan animula (gak ada di orion):
-- - Progress bar (Effects.OceanEffects.ProgressBar)
-- - Wave / Glass / Glow / Bubbles (Effects.OceanEffects)
-- - Motion.* (Animations.Motion) - Spring, SlideIn, Pop, TabSwitch, Shake, Pulse

Index.Notes = {
    html_vs_roblox = "TextSize di roblox = pixel Fixed, jangan pake TextScaled buat UI util",
    window_size    = "Desktop 600x400, Phone 0.92 scale, Tablet 0.76 - auto via Responsive.lua",
    tween_rule     = "jangan spam tween, pake Performance.Tween pooling, durasi 0.18-0.35s",
}

return Index
end)()

-- ===== ComponentsUI/Elements/Label/Label.lua (ElLabel) =====
__mods["ElLabel"] = (function()
-- Label/Label.lua - AddLabel buat animula ui
-- dipanggil dari TabManager: Tab:AddLabel(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddLabel(text: string)
        local f = card(36)
        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size             = UDim2.fromScale(1, 1)
        lbl.FontFace         = F.Body
        lbl.TextSize         = S.Body
        lbl.TextColor3       = T.Text
        lbl.TextXAlignment   = Enum.TextXAlignment.Left
        lbl.Text             = text
        lbl.Parent           = f
        local obj: any = { Value = text }
        function obj:Set(t: string)
            lbl.Text = t
            obj.Value = t
        end
        return obj
    end
    Tab.Label = Tab.AddLabel

    -- ── Paragraph ──────────────────────────────────────────────────────────
end

return Element
end)()

-- ===== ComponentsUI/Elements/Paragraph/Paragraph.lua (ElParagraph) =====
__mods["ElParagraph"] = (function()
-- Paragraph/Paragraph.lua - AddParagraph buat animula ui
-- dipanggil dari TabManager: Tab:AddParagraph(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddParagraph(title: string, content: string)
        -- Orion memanggil AddParagraph("Title","Content")
        -- Animula juga support AddParagraph({Title, Desc})
        local t: string
        local d: string
        if typeof(title) == "table" then
            local cfg: any = title
            t = cfg.Title or "Paragraph"
            d = cfg.Desc or cfg.Description or cfg.Content or ""
        else
            t = (title :: string) or "Paragraph"
            d = (content :: string) or ""
        end

        local f = card(64)
        f.AutomaticSize = Enum.AutomaticSize.Y

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, 0, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = t
        titleLbl.Parent        = f

        local descLbl = Instance.new("TextLabel")
        descLbl.BackgroundTransparency = 1
        descLbl.Position       = UDim2.fromOffset(0, 20)
        descLbl.Size           = UDim2.new(1, 0, 0, 14)
        descLbl.AutomaticSize  = Enum.AutomaticSize.Y
        descLbl.FontFace       = F.Body
        descLbl.TextSize       = S.Small
        descLbl.TextColor3     = T.TextDim
        descLbl.TextXAlignment = Enum.TextXAlignment.Left
        descLbl.TextWrapped    = true
        descLbl.Text           = d
        descLbl.Parent         = f

        task.defer(function()
            f.Size = UDim2.new(1, 0, 0, descLbl.TextBounds.Y + 34)
        end)

        local obj: any = {}
        function obj:Set(newTitle: string, newDesc: string?)
            titleLbl.Text = newTitle
            if newDesc then descLbl.Text = newDesc end
        end
        return obj
    end
    Tab.Paragraph = Tab.AddParagraph

    -- ── Section ────────────────────────────────────────────────────────────
end

return Element
end)()

-- ===== ComponentsUI/Elements/Section/Section.lua (ElSection) =====
__mods["ElSection"] = (function()
-- Section/Section.lua - AddSection buat animula ui
-- dipanggil dari TabManager: Tab:AddSection(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddSection(cfg: any)
        local name: string
        if typeof(cfg) == "string" then
            name = cfg
        elseif typeof(cfg) == "table" then
            name = (cfg :: any).Name or "Section"
        else
            name = "Section"
        end

        local f = Instance.new("Frame")
        f.BackgroundTransparency = 1
        f.Size   = UDim2.new(1, 0, 0, 22)
        f.Parent = page

        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size             = UDim2.fromScale(1, 1)
        lbl.FontFace         = F.Title
        lbl.TextSize         = S.Small
        lbl.TextColor3       = T.Accent
        lbl.TextXAlignment   = Enum.TextXAlignment.Left
        lbl.Text             = string.upper(name)
        lbl.Parent           = f
        return f
    end
    Tab.Section = Tab.AddSection

    -- ── Divider ────────────────────────────────────────────────────────────
end

return Element
end)()

-- ===== ComponentsUI/Elements/Divider/Divider.lua (ElDivider) =====
__mods["ElDivider"] = (function()
-- Divider/Divider.lua - AddDivider buat animula ui
-- dipanggil dari TabManager: Tab:AddDivider(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddDivider(text: string?)
        if typeof(text) == "table" then
            text = (text :: any).Name or (text :: any).Title
        end
        local f = Instance.new("Frame")
        f.BackgroundTransparency = 1
        f.Size   = UDim2.new(1, 0, 0, 20)
        f.Parent = page

        if text and text ~= "" then
            local lbl = Instance.new("TextLabel")
            lbl.BackgroundTransparency = 1
            lbl.Size       = UDim2.fromScale(1, 1)
            lbl.FontFace   = F.Heading
            lbl.TextSize   = S.Small
            lbl.TextColor3 = T.TextMuted
            lbl.Text       = "—  " .. text .. "  —"
            lbl.Parent     = f
        else
            local line = Instance.new("Frame")
            line.BackgroundColor3       = T.Border
            line.BackgroundTransparency = 0.45
            line.Size                   = UDim2.new(1, 0, 0, 1)
            line.Position               = UDim2.fromScale(0, 0.5)
            line.BorderSizePixel        = 0
            line.Parent                 = f
        end
        return f
    end
    Tab.Divider = Tab.AddDivider

    -- ── Button ─────────────────────────────────────────────────────────────
end

return Element
end)()

-- ===== ComponentsUI/Elements/Button/Button.lua (ElButton) =====
__mods["ElButton"] = (function()
-- Button/Button.lua - AddButton buat animula ui
-- dipanggil dari TabManager: Tab:AddButton(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddButton(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or cfg.Text or "Button"
        local desc: string? = cfg.Desc or cfg.Description
        local flag: string? = cfg.Flag
        local cb: (() -> ())? = cfg.Callback

        local h = if desc then 54 else 42
        local f = card(h)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -110, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        if desc then
            local d = Instance.new("TextLabel")
            d.BackgroundTransparency = 1
            d.Position       = UDim2.fromOffset(0, 18)
            d.Size           = UDim2.new(1, -110, 0, 14)
            d.FontFace       = F.Body
            d.TextSize       = S.Small
            d.TextColor3     = T.TextDim
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.Text           = desc
            d.Parent         = f
        end

        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = T.Primary
        btn.Size             = UDim2.fromOffset(96, 30)
        btn.Position         = UDim2.new(1, -96, 0.5, -15)
        btn.FontFace         = F.Heading
        btn.TextSize         = S.Small
        btn.TextColor3       = T.TextOnPrimary
        btn.Text             = cfg.ButtonText or "Execute"
        btn.AutoButtonColor  = false
        btn.Parent           = f
        Utils.Corner(btn, R.Small)
        Utils.Gradient(btn, T.Primary, T.PrimaryDark, 90)

        btn.MouseEnter:Connect(function()
            Utils.Tween(btn, { BackgroundColor3 = T.PrimaryLight }, 0.12)
        end)
        btn.MouseLeave:Connect(function()
            Utils.Tween(btn, { BackgroundColor3 = T.Primary }, 0.12)
        end)

        local function fire()
            if cb then task.spawn(cb) end
            if flag then Config:SetFlag(flag, true) end
        end
        btn.MouseButton1Click:Connect(fire)

        local obj: any = { Value = false }
        function obj:SetText(t: string) btn.Text = t end
        obj.Fire = fire
        return obj
    end
    Tab.Button = Tab.AddButton

end

return Element
end)()

-- ===== ComponentsUI/Elements/Toggle/Toggle.lua (ElToggle) =====
__mods["ElToggle"] = (function()
-- Toggle/Toggle.lua - AddToggle buat animula ui
-- dipanggil dari TabManager: Tab:AddToggle(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddToggle(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Toggle"
        local desc: string? = cfg.Desc or cfg.Description
        local def: boolean  = if cfg.Value ~= nil then cfg.Value
            elseif cfg.Default ~= nil then cfg.Default else false
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((boolean) -> ())? = cfg.Callback
        if flag then Config:SetFlag(flag, def) end

        local h = if desc then 54 else 42
        local f = card(h)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -64, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        if desc then
            local d = Instance.new("TextLabel")
            d.BackgroundTransparency = 1
            d.Position       = UDim2.fromOffset(0, 18)
            d.Size           = UDim2.new(1, -64, 0, 14)
            d.FontFace       = F.Body
            d.TextSize       = S.Small
            d.TextColor3     = T.TextDim
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.Text           = desc
            d.Parent         = f
        end

        local track = Instance.new("Frame")
        track.BackgroundColor3 = if def then T.ToggleOn else T.ToggleOff
        track.Size             = UDim2.fromOffset(44, 24)
        track.Position         = UDim2.new(1, -44, 0.5, -12)
        track.Parent           = f
        Utils.Corner(track, UDim.new(1, 0))
        Utils.Stroke(track, T.Border, 1, 0.4)

        local knob = Instance.new("Frame")
        knob.BackgroundColor3 = Color3.new(1, 1, 1)
        knob.Size     = UDim2.fromOffset(18, 18)
        knob.Position = if def then UDim2.fromOffset(23, 3) else UDim2.fromOffset(3, 3)
        knob.Parent   = track
        Utils.Corner(knob, UDim.new(1, 0))

        local hit = Instance.new("TextButton")
        hit.BackgroundTransparency = 1
        hit.Size = UDim2.fromScale(1, 1)
        hit.Text = ""
        hit.Parent = f

        local state: boolean = def
        local obj: any = { Value = state, Save = save }

        local function set(v: boolean, noCb: boolean?)
            state     = v
            obj.Value = v
            Utils.Tween(track, { BackgroundColor3 = if v then T.ToggleOn else T.ToggleOff }, 0.18)
            Utils.Tween(knob,  { Position = if v then UDim2.fromOffset(23, 3) else UDim2.fromOffset(3, 3) }, 0.18)
            if flag then Config:SetFlag(flag, v) end
            if not noCb and cb then task.spawn(cb, v) end
        end

        hit.MouseButton1Click:Connect(function() set(not state) end)
        if flag then Config:Register(flag, obj) end

        function obj:Set(v: boolean) set(v) end
        function obj:Get() return state end

        set(def, true)
        return obj
    end
    Tab.Toggle = Tab.AddToggle

end

return Element
end)()

-- ===== ComponentsUI/Elements/Slider/Slider.lua (ElSlider) =====
__mods["ElSlider"] = (function()
-- Slider/Slider.lua - AddSlider buat animula ui
-- dipanggil dari TabManager: Tab:AddSlider(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddSlider(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Slider"
        local min: number   = cfg.Min or cfg.Minimum or 0
        local max: number   = cfg.Max or cfg.Maximum or 100
        local def: number   = cfg.Value or cfg.Default or min
        local step: number  = cfg.Increment or cfg.Step or 1
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((number) -> ())? = cfg.Callback
        local suffix: string = cfg.Suffix or cfg.ValueName or ""
        if suffix ~= "" then suffix = " " .. suffix end

        def = math.clamp(def, min, max)
        if flag then Config:SetFlag(flag, def) end

        local f = card(62)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -70, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local valueLbl = Instance.new("TextLabel")
        valueLbl.BackgroundColor3 = T.SurfaceLight
        valueLbl.Size             = UDim2.fromOffset(62, 22)
        valueLbl.Position         = UDim2.new(1, -62, 0, 0)
        valueLbl.FontFace         = F.Heading
        valueLbl.TextSize         = S.Small
        valueLbl.TextColor3       = T.Accent
        valueLbl.Text             = tostring(def) .. suffix
        valueLbl.Parent           = f
        Utils.Corner(valueLbl, R.Small)
        Utils.Stroke(valueLbl, T.Border, 1, 0.5)

        local track = Instance.new("Frame")
        track.BackgroundColor3 = T.SliderTrack
        track.Size             = UDim2.new(1, 0, 0, 6)
        track.Position         = UDim2.fromOffset(0, 36)
        track.Parent           = f
        Utils.Corner(track, UDim.new(1, 0))

        local fill = Instance.new("Frame")
        fill.BackgroundColor3 = T.SliderFill
        fill.Size             = UDim2.new((def - min) / math.max(1, max - min), 0, 1, 0)
        fill.BorderSizePixel  = 0
        fill.Parent           = track
        Utils.Corner(fill, UDim.new(1, 0))
        Utils.Gradient(fill, T.Primary, T.Secondary, 0)

        local knob2 = Instance.new("Frame")
        knob2.BackgroundColor3 = Color3.new(1, 1, 1)
        knob2.Size     = UDim2.fromOffset(14, 14)
        knob2.Position = UDim2.new((def - min) / math.max(1, max - min), -7, 0.5, -7)
        knob2.Parent   = track
        Utils.Corner(knob2, UDim.new(1, 0))
        Utils.Stroke(knob2, T.Primary, 2, 0)

        local hit2 = Instance.new("TextButton")
        hit2.BackgroundTransparency = 1
        hit2.Size     = UDim2.new(1, 0, 0, 22)
        hit2.Position = UDim2.fromOffset(0, 28)
        hit2.Text     = ""
        hit2.Parent   = f

        local dragging = false
        local current: number = def
        local obj: any = { Value = def, Save = save }

        local function apply(v: number, noCb: boolean?)
            v = Utils.Round(Utils.Clamp(v, min, max), step)
            current   = v
            obj.Value = v
            local alpha = (v - min) / math.max(1, max - min)
            Utils.Tween(fill,  { Size = UDim2.new(alpha, 0, 1, 0) }, 0.08)
            Utils.Tween(knob2, { Position = UDim2.new(alpha, -7, 0.5, -7) }, 0.08)
            valueLbl.Text = tostring(v) .. suffix
            if flag then Config:SetFlag(flag, v) end
            if not noCb and cb then task.spawn(cb, v) end
        end

        local function fromInput(input: InputObject)
            local absPos  = track.AbsolutePosition.X
            local absSize = track.AbsoluteSize.X
            if absSize <= 0 then return end
            local rel = math.clamp((input.Position.X - absPos) / absSize, 0, 1)
            apply(min + rel * (max - min))
        end

        hit2.InputBegan:Connect(function(input: InputObject)
            local isMouse = input.UserInputType == Enum.UserInputType.MouseButton1
            local isTouch = input.UserInputType == Enum.UserInputType.Touch
            if isMouse or isTouch then
                dragging = true
                fromInput(input)
            end
        end)
        game:GetService("UserInputService").InputEnded:Connect(function(input: InputObject)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input: InputObject)
            local isMove = input.UserInputType == Enum.UserInputType.MouseMovement
            local isTouch = input.UserInputType == Enum.UserInputType.Touch
            if dragging and (isMove or isTouch) then fromInput(input) end
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(v: number) apply(v) end
        function obj:Get() return current end

        return obj
    end
    Tab.Slider = Tab.AddSlider

end

return Element
end)()

-- ===== ComponentsUI/Elements/Dropdown/Dropdown.lua (ElDropdown) =====
__mods["ElDropdown"] = (function()
-- Dropdown/Dropdown.lua - AddDropdown buat animula ui
-- dipanggil dari TabManager: Tab:AddDropdown(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddDropdown(cfg: any)
        cfg = cfg or {}
        local title: string   = cfg.Name or cfg.Title or "Dropdown"
        local options: {string} = cfg.Options or cfg.Values or cfg.List or { "Option 1" }
        local def: string?    = cfg.Default or cfg.Value
        local multi: boolean  = cfg.Multi or cfg.Multiple or false
        local flag: string?   = cfg.Flag
        local save: boolean   = cfg.Save or false
        local cb: ((any) -> ())? = cfg.Callback

        local selected: any = if multi then {} else (def or options[1])
        if multi and typeof(def) == "table" then selected = def end
        if flag then Config:SetFlag(flag, selected) end

        local f = card(52)
        f.ClipsDescendants = false
        f.ZIndex           = 2

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, 0, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local box = Instance.new("TextButton")
        box.BackgroundColor3 = T.SurfaceLight
        box.Size             = UDim2.new(1, 0, 0, 28)
        box.Position         = UDim2.fromOffset(0, 22)
        box.FontFace         = F.Body
        box.TextSize         = S.Small
        box.TextColor3       = T.Text
        box.Text             = ""
        box.AutoButtonColor  = false
        box.ClipsDescendants = false
        box.Parent           = f
        Utils.Corner(box, R.Small)
        Utils.Stroke(box, T.Border, 1, 0.4)
        Utils.Padding(box, 10, 0, 30, 0)

        local boxText = Instance.new("TextLabel")
        boxText.BackgroundTransparency = 1
        boxText.Size          = UDim2.fromScale(1, 1)
        boxText.FontFace      = F.Body
        boxText.TextSize      = S.Small
        boxText.TextColor3    = T.Text
        boxText.TextXAlignment = Enum.TextXAlignment.Left
        boxText.TextTruncate  = Enum.TextTruncate.AtEnd
        boxText.Parent        = box

        local arrow = Instance.new("TextLabel")
        arrow.BackgroundTransparency = 1
        arrow.Size       = UDim2.fromOffset(20, 20)
        arrow.Position   = UDim2.new(1, -24, 0.5, -10)
        arrow.FontFace   = F.Body
        arrow.TextSize   = 12
        arrow.TextColor3 = T.TextMuted
        arrow.Text       = "▾"
        arrow.Parent     = box

        local function displayText(): string
            if multi then
                if typeof(selected) == "table" and #selected > 0 then
                    return table.concat(selected, ", ")
                else
                    return "Select..."
                end
            else
                return tostring(selected)
            end
        end
        boxText.Text = displayText()

        -- List frame
        local listFrame = Instance.new("Frame")
        listFrame.Name              = "List"
        listFrame.BackgroundColor3  = T.SurfaceLight
        listFrame.Size              = UDim2.new(1, 0, 0, 0)
        listFrame.Position          = UDim2.new(0, 0, 1, 6)
        listFrame.Visible           = false
        listFrame.ClipsDescendants  = true
        listFrame.Parent            = box
        Utils.Corner(listFrame, R.Small)
        Utils.Stroke(listFrame, T.Border, 1, 0.35)

        local listScroll = Instance.new("ScrollingFrame")
        listScroll.BackgroundTransparency = 1
        listScroll.Size               = UDim2.fromScale(1, 1)
        listScroll.CanvasSize         = UDim2.fromOffset(0, 0)
        listScroll.ScrollBarThickness = 2
        listScroll.BorderSizePixel    = 0
        listScroll.Parent             = listFrame
        Utils.Padding(listScroll, 4, 4, 4, 4)

        local listLayout = Instance.new("UIListLayout")
        listLayout.FillDirection = Enum.FillDirection.Vertical
        listLayout.Padding       = UDim.new(0, 2)
        listLayout.Parent        = listScroll

        local open = false
        local function setOpen(v: boolean)
            open              = v
            listFrame.Visible = v
            arrow.Text        = if v then "▴" else "▾"
            if v then
                local h = math.clamp(#options * 30 + 8, 30, 150)
                Utils.Tween(listFrame, { Size = UDim2.new(1, 0, 0, h) }, 0.18)
                listScroll.CanvasSize = UDim2.fromOffset(0, #options * 32)
            else
                Utils.Tween(listFrame, { Size = UDim2.new(1, 0, 0, 0) }, 0.14)
            end
        end

        local obj: any = { Value = selected, Save = save }

        local function refreshText()
            boxText.Text = displayText()
            obj.Value    = selected
            if flag then Config:SetFlag(flag, selected) end
            if cb then task.spawn(cb, selected) end
        end

        local function buildItems()
            for _, ch in ipairs(listScroll:GetChildren()) do
                if ch:IsA("TextButton") then ch:Destroy() end
            end
            for _, opt in ipairs(options) do
                local item = Instance.new("TextButton")
                item.BackgroundColor3 = T.Surface
                item.Size             = UDim2.new(1, 0, 0, 28)
                item.FontFace         = F.Body
                item.TextSize         = S.Small
                item.TextColor3       = T.TextDim
                item.Text             = "  " .. opt
                item.TextXAlignment   = Enum.TextXAlignment.Left
                item.AutoButtonColor  = false
                item.Parent           = listScroll
                Utils.Corner(item, R.Small)

                local function isSelected(): boolean
                    if multi then
                        if typeof(selected) ~= "table" then return false end
                        return table.find(selected, opt) ~= nil
                    else
                        return selected == opt
                    end
                end

                local function updateLook()
                    if isSelected() then
                        item.BackgroundColor3 = T.Primary
                        item.TextColor3       = T.TextOnPrimary
                    else
                        item.BackgroundColor3 = T.Surface
                        item.TextColor3       = T.TextDim
                    end
                end
                updateLook()

                item.MouseEnter:Connect(function()
                    if not isSelected() then
                        Utils.Tween(item, { BackgroundColor3 = T.SurfaceHover }, 0.1)
                    end
                end)
                item.MouseLeave:Connect(updateLook)

                item.MouseButton1Click:Connect(function()
                    if multi then
                        if typeof(selected) ~= "table" then selected = {} end
                        local idx = table.find(selected, opt)
                        if idx then table.remove(selected, idx)
                        else table.insert(selected, opt) end
                    else
                        selected = opt
                        setOpen(false)
                    end
                    for _, ch in ipairs(listScroll:GetChildren()) do
                        if ch:IsA("TextButton") then
                            local txt: string = (ch :: TextButton).Text:gsub("^%s+", "")
                            local sel: boolean = if multi
                                then (typeof(selected) == "table" and table.find(selected, txt) ~= nil)
                                else (selected == txt)
                            if sel then
                                ch.BackgroundColor3            = T.Primary
                                ;(ch :: TextButton).TextColor3 = T.TextOnPrimary
                            else
                                ch.BackgroundColor3            = T.Surface
                                ;(ch :: TextButton).TextColor3 = T.TextDim
                            end
                        end
                    end
                    refreshText()
                end)
            end
        end
        buildItems()

        box.MouseButton1Click:Connect(function() setOpen(not open) end)
        game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject)
            if open and input.UserInputType == Enum.UserInputType.MouseButton1 then
                local pos     = input.Position
                local absPos  = box.AbsolutePosition
                local absSize = box.AbsoluteSize
                local inBox   = pos.X >= absPos.X and pos.X <= absPos.X + absSize.X
                    and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y + listFrame.AbsoluteSize.Y + 6
                if not inBox then setOpen(false) end
            end
        end)

        if flag then Config:Register(flag, obj) end

        function obj:Set(v: any)
            selected = v
            refreshText()
        end
        function obj:Get() return selected end
        function obj:Refresh(newOpts: {string}, clear: boolean?)
            if clear then options = {} end
            options = newOpts
            buildItems()
            boxText.Text = displayText()
        end
        function obj:SetOptions(newOpts: {string}) self:Refresh(newOpts, true) end

        return obj
    end
    Tab.Dropdown = Tab.AddDropdown

end

return Element
end)()

-- ===== ComponentsUI/Elements/Textbox/Textbox.lua (ElTextbox) =====
__mods["ElTextbox"] = (function()
-- Textbox/Textbox.lua - AddTextbox buat animula ui
-- dipanggil dari TabManager: Tab:AddTextbox(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddTextbox(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Input"
        local placeholder: string = cfg.Placeholder or cfg.PlaceHolder or "Enter text..."
        local def: string   = cfg.Default or cfg.Value or ""
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((string) -> ())? = cfg.Callback
        local disappear: boolean = cfg.TextDisappear or false
        local numeric: boolean   = cfg.Numeric or false

        if flag and def ~= "" then Config:SetFlag(flag, def) end

        local f = card(52)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, 0, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local box = Instance.new("TextBox")
        box.BackgroundColor3   = T.Background
        box.Size               = UDim2.new(1, 0, 0, 28)
        box.Position           = UDim2.fromOffset(0, 22)
        box.FontFace           = F.Body
        box.TextSize           = S.Small
        box.TextColor3         = T.Text
        box.PlaceholderColor3  = T.TextMuted
        box.PlaceholderText    = placeholder
        box.Text               = def
        box.ClearTextOnFocus   = disappear
        box.Parent             = f
        Utils.Corner(box, R.Small)
        Utils.Stroke(box, T.Border, 1, 0.4)
        Utils.Padding(box, 10, 0, 10, 0)

        local obj: any = { Value = def, Save = save }

        box.Focused:Connect(function()
            local st = box:FindFirstChildOfClass("UIStroke") :: UIStroke?
            if st then Utils.Tween(st, { Color = T.Primary }, 0.15) end
        end)
        box.FocusLost:Connect(function()
            local st = box:FindFirstChildOfClass("UIStroke") :: UIStroke?
            if st then Utils.Tween(st, { Color = T.Border }, 0.15) end
            local val: string = box.Text
            if numeric then
                local n = tonumber(val)
                if n == nil then box.Text = def; return end
                val      = tostring(n)
                box.Text = val
            end
            obj.Value = val
            if flag then Config:SetFlag(flag, val) end
            if cb then task.spawn(cb, val) end
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(v: string) box.Text = v; obj.Value = v end
        function obj:Get() return box.Text end

        return obj
    end
    Tab.Textbox      = Tab.AddTextbox
    Tab.Input        = Tab.AddTextbox
    Tab.AddInput     = Tab.AddTextbox

end

return Element
end)()

-- ===== ComponentsUI/Elements/ColorPicker/ColorPicker.lua (ElColorPicker) =====
__mods["ElColorPicker"] = (function()
-- ColorPicker/ColorPicker.lua - AddColorpicker buat animula ui
-- dipanggil dari TabManager: Tab:AddColorpicker(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddColorpicker(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Colorpicker"
        local def: Color3   = cfg.Default or cfg.Value or T.Primary
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((Color3) -> ())? = cfg.Callback
        if flag then Config:SetFlag(flag, def) end

        local f = card(42)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -50, 1, 0)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local preview = Instance.new("Frame")
        preview.BackgroundColor3 = def
        preview.Size     = UDim2.fromOffset(32, 24)
        preview.Position = UDim2.new(1, -32, 0.5, -12)
        preview.Parent   = f
        Utils.Corner(preview, R.Small)
        Utils.Stroke(preview, T.Border, 1, 0.4)

        local hit = Instance.new("TextButton")
        hit.BackgroundTransparency = 1
        hit.Size = UDim2.fromScale(1, 1)
        hit.Text = ""
        hit.Parent = f

        local current: Color3 = def
        local obj: any = { Value = def, Save = save }

        local function set(c: Color3, noCb: boolean?)
            current       = c
            obj.Value     = c
            preview.BackgroundColor3 = c
            if flag then Config:SetFlag(flag, c) end
            if not noCb and cb then task.spawn(cb, c) end
        end

        -- Popup picker
        local pickerOpen = false
        local picker: Frame? = nil

        local function openPicker()
            if pickerOpen then return end
            pickerOpen = true

            local pf = Instance.new("Frame")
            pf.Name              = "ColorPickerPopup"
            pf.BackgroundColor3  = T.SurfaceLight
            pf.Size              = UDim2.fromOffset(220, 160)
            pf.Position          = UDim2.new(1, -230, 0, 42)
            pf.Parent            = f
            pf.ZIndex            = 10
            Utils.Corner(pf, R.Medium)
            Utils.Stroke(pf, T.Border, 1, 0.4)
            Utils.Padding(pf, 10, 10, 10, 10)
            picker = pf

            local hueBar = Instance.new("Frame")
            hueBar.BackgroundColor3 = Color3.new(1, 1, 1)
            hueBar.Size   = UDim2.new(1, 0, 0, 18)
            hueBar.Parent = pf
            Utils.Corner(hueBar, R.Small)
            local hg = Instance.new("UIGradient")
            hg.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,    Color3.fromHSV(0,    1, 1)),
                ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.17, 1, 1)),
                ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33, 1, 1)),
                ColorSequenceKeypoint.new(0.50, Color3.fromHSV(0.50, 1, 1)),
                ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.67, 1, 1)),
                ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83, 1, 1)),
                ColorSequenceKeypoint.new(1,    Color3.fromHSV(1,    1, 1)),
            })
            hg.Parent = hueBar

            local satVal = Instance.new("Frame")
            satVal.BackgroundColor3 = current
            satVal.Size     = UDim2.new(1, 0, 0, 90)
            satVal.Position = UDim2.fromOffset(0, 26)
            satVal.Parent   = pf
            Utils.Corner(satVal, R.Small)

            local closeBtn = Instance.new("TextButton")
            closeBtn.BackgroundColor3 = T.Primary
            closeBtn.Size     = UDim2.new(1, 0, 0, 28)
            closeBtn.Position = UDim2.fromOffset(0, 122)
            closeBtn.FontFace = F.Heading
            closeBtn.TextSize = S.Small
            closeBtn.TextColor3 = T.TextOnPrimary
            closeBtn.Text     = "Close"
            closeBtn.Parent   = pf
            Utils.Corner(closeBtn, R.Small)

            local function pickFromMouse(input: InputObject, frame: Frame, isHue: boolean)
                local absPos  = frame.AbsolutePosition.X
                local absSize = frame.AbsoluteSize.X
                if absSize <= 0 then return end
                local rel = math.clamp((input.Position.X - absPos) / absSize, 0, 1)
                local h, s, v = current:ToHSV()
                if isHue then h = rel else s = rel end
                local c = Color3.fromHSV(h, s, v)
                set(c)
                satVal.BackgroundColor3 = c
            end

            local draggingHue = false
            hueBar.InputBegan:Connect(function(i: InputObject)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingHue = true
                    pickFromMouse(i, hueBar, true)
                end
            end)
            satVal.InputBegan:Connect(function(i: InputObject)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    pickFromMouse(i, satVal, false)
                end
            end)
            game:GetService("UserInputService").InputChanged:Connect(function(i: InputObject)
                if draggingHue and i.UserInputType == Enum.UserInputType.MouseMovement then
                    pickFromMouse(i, hueBar, true)
                end
            end)
            game:GetService("UserInputService").InputEnded:Connect(function(i: InputObject)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingHue = false
                end
            end)
            closeBtn.MouseButton1Click:Connect(function()
                pickerOpen = false
                if picker then picker:Destroy(); picker = nil end
            end)
        end

        hit.MouseButton1Click:Connect(function()
            if pickerOpen then
                pickerOpen = false
                if picker then picker:Destroy(); picker = nil end
            else
                openPicker()
            end
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(c: Color3) set(c) end
        function obj:Get() return current end

        return obj
    end
    Tab.Colorpicker = Tab.AddColorpicker
    Tab.AddColorPicker = Tab.AddColorpicker

end

return Element
end)()

-- ===== ComponentsUI/Elements/Keybind/Keybind.lua (ElKeybind) =====
__mods["ElKeybind"] = (function()
-- Keybind/Keybind.lua - AddBind buat animula ui
-- dipanggil dari TabManager: Tab:AddBind(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddBind(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Bind"
        local def: Enum.KeyCode = cfg.Default or cfg.Value or Enum.KeyCode.F
        -- Orion's Default bisa string; handle
        if typeof(def) == "string" then
            local ok, kc = pcall(function()
                return Enum.KeyCode[def :: string]
            end)
            if ok and kc then def = kc end
        end
        local hold: boolean = cfg.Hold or false
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((Enum.KeyCode) -> ())? = cfg.Callback
        if flag then Config:SetFlag(flag, def) end

        local f = card(42)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -90, 1, 0)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local keyBtn = Instance.new("TextButton")
        keyBtn.BackgroundColor3 = T.Background
        keyBtn.Size     = UDim2.fromOffset(80, 26)
        keyBtn.Position = UDim2.new(1, -80, 0.5, -13)
        keyBtn.FontFace = F.Body
        keyBtn.TextSize = S.Small
        keyBtn.TextColor3 = T.Text
        keyBtn.Text     = (def :: Enum.KeyCode).Name
        keyBtn.AutoButtonColor = false
        keyBtn.Parent   = f
        Utils.Corner(keyBtn, R.Small)
        Utils.Stroke(keyBtn, T.Border, 1, 0.4)

        local current: Enum.KeyCode = def :: Enum.KeyCode
        local listening = false
        local obj: any = { Value = current, Save = save }

        local function set(k: Enum.KeyCode)
            current   = k
            obj.Value = k
            keyBtn.Text = k.Name
            if flag then Config:SetFlag(flag, k) end
            if cb then task.spawn(cb, k) end
        end

        -- Hold mode
        if hold and cb then
            game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.KeyCode == current then task.spawn(cb, true) end
            end)
            game:GetService("UserInputService").InputEnded:Connect(function(input: InputObject)
                if input.KeyCode == current then task.spawn(cb, false) end
            end)
        elseif cb then
            game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.KeyCode == current then task.spawn(cb, current) end
            end)
        end

        keyBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            keyBtn.Text      = "..."
            keyBtn.TextColor3 = T.Primary
            local conn: RBXScriptConnection
            conn = game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    conn:Disconnect()
                    listening = false
                    keyBtn.TextColor3 = T.Text
                    set(input.KeyCode)
                end
            end)
            task.delay(5, function()
                if listening then
                    listening = false
                    if conn.Connected then conn:Disconnect() end
                    keyBtn.Text      = current.Name
                    keyBtn.TextColor3 = T.Text
                end
            end)
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(k: Enum.KeyCode) set(k) end
        function obj:Get() return current end

        return obj
    end
    Tab.Bind        = Tab.AddBind
    Tab.Keybind     = Tab.AddBind
    Tab.AddKeybind  = Tab.AddBind
end

-- =============================================================================
--  Attach tabs ke Window
-- =============================================================================
end

return Element
end)()

-- ===== ComponentsUI/Window/Effects/Wave.lua (Wave) =====
__mods["Wave"] = (function()
-- Window/Effects/Wave.lua - efek ombak di belakang window
-- dipisah biar Window.lua gak kepanjangan wkwk

local Performance = __require("Performance")

local Wave = {}

function Wave.Attach(main: Frame, T: any): Frame
    local wave = Instance.new("Frame")
    wave.Name                   = "WaveFX"
    wave.BackgroundColor3       = T.Wave1
    wave.BackgroundTransparency = 0.90
    wave.Size                   = UDim2.fromScale(1, 1)
    wave.BorderSizePixel        = 0
    wave.ZIndex                 = 1
    wave.Parent                 = main

    local wc = Instance.new("UICorner")
    wc.CornerRadius = UDim.new(0, 16)
    wc.Parent       = wave

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   T.Wave1),
        ColorSequenceKeypoint.new(0.5, T.Wave2),
        ColorSequenceKeypoint.new(1,   T.PrimaryDark),
    })
    grad.Rotation = 18
    grad.Offset   = Vector2.new(-0.2, 0)
    grad.Parent   = wave

    task.spawn(function()
        local dir = 1
        while grad.Parent do
            local target = if dir == 1 then Vector2.new(0.2, 0) else Vector2.new(-0.2, 0)
            local tw = Performance.Tween(grad, { Offset = target }, 5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            tw.Completed:Wait()
            if not grad.Parent then break end
            dir *= -1
        end
    end)

    local shimmer = Instance.new("Frame")
    shimmer.Name                   = "WaveShimmer"
    shimmer.BackgroundColor3       = Color3.new(1, 1, 1)
    shimmer.BackgroundTransparency = 1
    shimmer.Size                   = UDim2.fromScale(1, 1)
    shimmer.BorderSizePixel        = 0
    shimmer.ZIndex                 = 2
    shimmer.Parent                 = main
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 16)
    sc.Parent       = shimmer

    return wave
end

return Wave
end)()

-- ===== ComponentsUI/Window/Effects/Bubbles.lua (Bubbles) =====
__mods["Bubbles"] = (function()
-- Window/Effects/Bubbles.lua - gelembung naik di content
-- lucu sih tapi jangan kebanyakan, 5 aja cukup biar gak lag

local Performance = __require("Performance")

local Bubbles = {}

function Bubbles.Spawn(parent: Frame)
    for i = 1, 5 do
        local sz: number = math.random(3, 7)
        local b = Instance.new("Frame")
        b.Name                   = "Bubble" .. tostring(i)
        b.BackgroundColor3       = Color3.fromRGB(180, 220, 255)
        b.BackgroundTransparency = 0.65
        b.Size                   = UDim2.fromOffset(sz, sz)
        b.Position               = UDim2.new(math.random() * 0.9 + 0.05, 0, 1, math.random(-10, 10))
        b.BorderSizePixel        = 0
        b.ZIndex                 = 4
        b.Parent                 = parent

        local cr = Instance.new("UICorner")
        cr.CornerRadius = UDim.new(1, 0)
        cr.Parent       = b

        local st = Instance.new("UIStroke")
        st.Color        = Color3.fromRGB(155, 214, 255)
        st.Thickness    = 1
        st.Transparency = 0.6
        st.Parent       = b

        local function float()
            if not b.Parent then return end
            local sx: number = math.random() * 0.8 + 0.1
            b.Position = UDim2.new(sx, 0, 1, 6)
            local ex: number = sx + (math.random() - 0.5) * 0.08
            local dur: number = math.random(5, 9)
            Performance.Tween(b, { Position = UDim2.new(ex, 0, 0, -6) }, dur, Enum.EasingStyle.Linear).Completed:Connect(function()
                if b.Parent then
                    task.wait(math.random() * 1.2)
                    float()
                end
            end)
        end
        task.delay(math.random() * 2.5, float)
    end
end

return Bubbles
end)()

-- ===== ComponentsUI/Window/Header/TitleBar.lua (TitleBar) =====
__mods["TitleBar"] = (function()
-- Window/Header/TitleBar.lua - header window (icon + title + subtitle + controls)
-- glow di icon + ring gold + shimmer accent bar, premium abis

local Utils       = __require("Utils")
local Performance = __require("Performance")

local TitleBar = {}

export type TitleBarResult = {
    bar: Frame,
    iconLabel: TextLabel,
    titleLabel: TextLabel,
    subLabel: TextLabel,
    controls: Frame,
}

function TitleBar.Build(
    main: Frame,
    T: any,
    R: any,
    F: any,
    S: any,
    title: string,
    subTitle: string,
    icon: string?
): TitleBarResult
    local bar = Instance.new("Frame")
    bar.Name                   = "TitleBar"
    bar.BackgroundTransparency = 1
    bar.Size                   = UDim2.new(1, 0, 0, 52)
    bar.Position               = UDim2.fromOffset(0, 3)
    bar.ZIndex                 = 6
    bar.Parent                 = main

    -- icon bulat + gradient
    local iconWrap = Instance.new("Frame")
    iconWrap.Name             = "IconWrap"
    iconWrap.BackgroundColor3 = T.Primary
    iconWrap.Size             = UDim2.fromOffset(36, 36)
    iconWrap.Position         = UDim2.fromOffset(14, 8)
    iconWrap.ZIndex           = 7
    iconWrap.Parent           = bar
    Utils.Corner(iconWrap, UDim.new(1, 0))
    Utils.Gradient(iconWrap, T.Primary, T.Secondary, 35)

    -- glow belakang icon
    do
        local glow = Instance.new("ImageLabel")
        glow.Name              = "IconGlow"
        glow.BackgroundTransparency = 1
        glow.Image             = "rbxassetid://5028857084"
        glow.ImageColor3       = T.Glow
        glow.ImageTransparency = 0.55
        glow.ScaleType         = Enum.ScaleType.Slice
        glow.SliceCenter       = Rect.new(24, 24, 276, 276)
        glow.Size              = UDim2.new(1, 18, 1, 18)
        glow.Position          = UDim2.fromOffset(-9, -9)
        glow.ZIndex            = 6
        glow.Parent            = iconWrap
        task.spawn(function()
            while glow.Parent do
                Performance.Tween(glow, { ImageTransparency = 0.75 }, 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
                if not glow.Parent then break end
                Performance.Tween(glow, { ImageTransparency = 0.45 }, 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
            end
        end)
    end

    -- ring gold
    do
        local ring = Instance.new("UIStroke")
        ring.Color        = T.AccentGold
        ring.Thickness    = 1.5
        ring.Transparency = 0.3
        ring.Parent       = iconWrap
    end

    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name                   = "Icon"
    iconLabel.BackgroundTransparency = 1
    iconLabel.Size                   = UDim2.fromScale(1, 1)
    iconLabel.FontFace               = F.Title
    iconLabel.TextSize               = 18
    iconLabel.TextColor3             = T.TextOnPrimary
    iconLabel.Text                   = "◈"
    iconLabel.ZIndex                 = 8
    iconLabel.Parent                 = iconWrap
    if icon and #icon <= 4 then
        iconLabel.Text = icon
    end

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name                   = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position               = UDim2.fromOffset(58, 6)
    titleLabel.Size                   = UDim2.new(1, -140, 0, 20)
    titleLabel.FontFace               = F.Title
    titleLabel.TextSize               = S.Title
    titleLabel.TextColor3             = T.Text
    titleLabel.TextXAlignment         = Enum.TextXAlignment.Left
    titleLabel.TextTruncate           = Enum.TextTruncate.AtEnd
    titleLabel.Text                   = title
    titleLabel.ZIndex                 = 7
    titleLabel.Parent                 = bar

    local subLabel = Instance.new("TextLabel")
    subLabel.Name                   = "SubTitle"
    subLabel.BackgroundTransparency = 1
    subLabel.Position               = UDim2.fromOffset(58, 26)
    subLabel.Size                   = UDim2.new(1, -140, 0, 14)
    subLabel.FontFace               = F.Body
    subLabel.TextSize               = S.Small
    subLabel.TextColor3             = T.TextDim
    subLabel.TextXAlignment         = Enum.TextXAlignment.Left
    subLabel.Text                   = subTitle
    subLabel.ZIndex                 = 7
    subLabel.Parent                 = bar

    -- controls (min & close)
    local controls = Instance.new("Frame")
    controls.Name                   = "Controls"
    controls.BackgroundTransparency = 1
    controls.Size                   = UDim2.fromOffset(64, 32)
    controls.Position               = UDim2.new(1, -72, 0, 10)
    controls.ZIndex                 = 7
    controls.Parent                 = bar

    local layout = Instance.new("UIListLayout")
    layout.FillDirection       = Enum.FillDirection.Horizontal
    layout.Padding             = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    layout.Parent              = controls

    return {
        bar = bar,
        iconLabel = iconLabel,
        titleLabel = titleLabel,
        subLabel = subLabel,
        controls = controls,
    }
end

return TitleBar
end)()

-- ===== ComponentsUI/Window/Sidebar/Sidebar.lua (Sidebar) =====
__mods["Sidebar"] = (function()
-- Window/Sidebar/Sidebar.lua - sidebar kiri (daftar tabs)
-- simple tapi elegan, ada collapse buat HP

local Utils = __require("Utils")

local Sidebar = {}

export type SidebarResult = {
    frame: ScrollingFrame,
    list: UIListLayout,
}

function Sidebar.Build(body: Frame, T: any, R: any): SidebarResult
    local frame = Instance.new("ScrollingFrame")
    frame.Name                    = "Sidebar"
    frame.BackgroundColor3        = T.Background
    frame.BackgroundTransparency  = 0.22
    frame.Size                    = UDim2.new(0, 168, 1, -12)
    frame.Position                = UDim2.fromOffset(8, 6)
    frame.CanvasSize              = UDim2.fromOffset(0, 0)
    frame.ScrollBarThickness      = 2
    frame.ScrollBarImageColor3    = T.Primary
    frame.ScrollingDirection      = Enum.ScrollingDirection.Y
    frame.BorderSizePixel         = 0
    frame.ZIndex                  = 5
    frame.Parent                  = body
    Utils.Corner(frame, R.Large)
    Utils.Stroke(frame, T.Border, 1, 0.45)
    Utils.Padding(frame, 6, 8, 6, 8)

    local list = Instance.new("UIListLayout")
    list.FillDirection = Enum.FillDirection.Vertical
    list.Padding       = UDim.new(0, 4)
    list.SortOrder     = Enum.SortOrder.LayoutOrder
    list.Parent        = frame

    return { frame = frame, list = list }
end

return Sidebar
end)()

-- ===== ComponentsUI/Window/Content/Content.lua (ContentMod) =====
__mods["ContentMod"] = (function()
-- Window/Content/Content.lua - content wrap + scrolling
-- glass effect + highlight + responsive collapse support

local Utils   = __require("Utils")
local Bubbles     = __require("Bubbles")

local Content = {}

export type ContentResult = {
    wrap: Frame,
    scroll: ScrollingFrame,
    list: UIListLayout,
}

function Content.Build(
    body: Frame,
    T: any,
    R: any,
    isPhone: boolean
): ContentResult
    local sidebarW: number = if isPhone then 0 else 168
    local contentX: number = if isPhone then 8 else 176
    local contentW: number = if isPhone then -16 else -184

    local wrap = Instance.new("Frame")
    wrap.Name                     = "ContentWrap"
    wrap.BackgroundColor3         = T.SurfaceLight
    wrap.BackgroundTransparency   = 0.08
    wrap.Size                     = UDim2.new(1, contentW, 1, -12)
    wrap.Position                 = UDim2.new(0, contentX, 0, 6)
    wrap.ZIndex                   = 5
    wrap.ClipsDescendants         = true
    wrap.Parent                   = body
    Utils.Corner(wrap, R.Large)
    Utils.Stroke(wrap, T.Border, 1, 0.38)

    -- glass highlight atas
    do
        local hl = Instance.new("Frame")
        hl.Name                   = "Highlight"
        hl.BackgroundColor3       = Color3.new(1, 1, 1)
        hl.BackgroundTransparency = 0.94
        hl.Size                   = UDim2.new(1, -2, 0, 1)
        hl.Position               = UDim2.fromOffset(1, 1)
        hl.BorderSizePixel        = 0
        hl.ZIndex                 = 6
        hl.Parent                 = wrap
    end

    -- bubbles biar hidup, ringan kok
    Bubbles.Spawn(wrap)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name                         = "Content"
    scroll.BackgroundTransparency       = 1
    scroll.Size                         = UDim2.fromScale(1, 1)
    scroll.CanvasSize                   = UDim2.fromOffset(0, 0)
    scroll.ScrollBarThickness           = 3
    scroll.ScrollBarImageColor3         = T.Primary
    scroll.ScrollBarImageTransparency   = 0.3
    scroll.BorderSizePixel              = 0
    scroll.ZIndex                       = 6
    scroll.Parent                       = wrap
    Utils.Padding(scroll, 14, 14, 14, 14)

    local list = Instance.new("UIListLayout")
    list.FillDirection = Enum.FillDirection.Vertical
    list.Padding       = UDim.new(0, 10)
    list.SortOrder     = Enum.SortOrder.LayoutOrder
    list.Parent        = scroll

    return { wrap = wrap, scroll = scroll, list = list }
end

return Content
end)()

-- ===== ComponentsUI/Window/Window.lua (WindowMod) =====
__mods["WindowMod"] = (function()
-- window.lua - orchestrator window animula (sekarang modular)
-- dipecah jadi Header/TitleBar, Sidebar/Sidebar, Content/Content, Effects/Wave+Bubbles
-- jadi ComponentsUI/Window keliatan rapih, gak satu file 600 baris wkwk

local Theme       = __require("AnimulaTheme")
local Utils       = __require("Utils")
local Config      = __require("Config")
local Performance = __require("Performance")
local Responsive  = __require("Responsive")
local TitleBar    = __require("TitleBar"):FindFirstChild("TitleBar"))
local Sidebar     = __require("Sidebar"):FindFirstChild("Sidebar"))
local ContentMod  = __require("ContentMod"):FindFirstChild("Content"))
local Wave        = __require("Wave"):FindFirstChild("Wave"))
local Bubbles     = __require("Bubbles"):FindFirstChild("Bubbles"))

local HttpService      = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local Window = {}
Window.__index = Window

export type WindowConfig = {
    Name: string?,
    Title: string?, -- alias, biar kompat sama orion
    SubTitle: string?,
    Icon: string?,
    Author: string?,
    Size: UDim2?,
    Theme: string?,
    SaveConfig: boolean?,
    ConfigFolder: string?,
    IntroEnabled: boolean?,
    IntroText: string?,
    CloseCallback: (() -> ())?,
    ToggleKey: Enum.KeyCode?,
    Draggable: boolean?,
}

-- helper kecil buat bikin wave layer di belakang window
-- gw taro di dalem file ini aja biar gak kebanyakan require
local function attachWave(main: Frame, T: any)
    -- wave 1 - biru muda transparan, gerak pelan
    local wave = Instance.new("Frame")
    wave.Name                   = "WaveFX"
    wave.BackgroundColor3       = T.Wave1
    wave.BackgroundTransparency = 0.90
    wave.Size                   = UDim2.fromScale(1, 1)
    wave.BorderSizePixel        = 0
    wave.ZIndex                 = 1
    wave.Parent                 = main
    -- corner nya ngikut window
    local wc = Instance.new("UICorner")
    wc.CornerRadius = UDim.new(0, 16)
    wc.Parent       = wave
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   T.Wave1),
        ColorSequenceKeypoint.new(0.5, T.Wave2),
        ColorSequenceKeypoint.new(1,   T.PrimaryDark),
    })
    grad.Rotation = 18
    grad.Offset   = Vector2.new(-0.2, 0)
    grad.Parent   = wave

    -- animasi bolak balik, pelan aja biar gak pusing
    task.spawn(function()
        local dir = 1
        while grad.Parent do
            local target = if dir == 1 then Vector2.new(0.2, 0) else Vector2.new(-0.2, 0)
            local tw = Performance.Tween(grad, { Offset = target }, 5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            tw.Completed:Wait()
            if not grad.Parent then break end
            dir *= -1
        end
    end)

    -- shimmer di atas wave biar kilau
    local shimmer = Instance.new("Frame")
    shimmer.Name                   = "WaveShimmer"
    shimmer.BackgroundColor3       = Color3.new(1, 1, 1)
    shimmer.BackgroundTransparency = 1
    shimmer.Size                   = UDim2.fromScale(1, 1)
    shimmer.BorderSizePixel        = 0
    shimmer.ZIndex                 = 2
    shimmer.Parent                 = main
    local sc = Instance.new("UICorner")
    sc.CornerRadius = UDim.new(0, 16)
    sc.Parent       = shimmer
    -- shimmer di handle sama OceanEffects kalo ada, tapi kita bikin simple aja disini
    -- biar gak perlu require lagi

    return wave
end

-- bubble kecil2 di pinggir window, lucu sih
local function spawnBubbles(parent: Frame)
    -- cuma 5 bubble, jangan kebanyakan ntar lag
    for i = 1, 5 do
        local sz: number = math.random(3, 7)
        local b = Instance.new("Frame")
        b.Name                   = "Bubble" .. tostring(i)
        b.BackgroundColor3       = Color3.fromRGB(180, 220, 255)
        b.BackgroundTransparency = 0.65
        b.Size                   = UDim2.fromOffset(sz, sz)
        b.Position               = UDim2.new(math.random() * 0.9 + 0.05, 0, 1, math.random(-10, 10))
        b.BorderSizePixel        = 0
        b.ZIndex                 = 4
        b.Parent                 = parent
        local cr = Instance.new("UICorner")
        cr.CornerRadius = UDim.new(1, 0)
        cr.Parent       = b
        -- outline tipis biar keliatan
        local st = Instance.new("UIStroke")
        st.Color       = Color3.fromRGB(155, 214, 255)
        st.Thickness   = 1
        st.Transparency = 0.6
        st.Parent      = b

        local function float()
            if not b.Parent then return end
            local sx: number = math.random() * 0.8 + 0.1
            b.Position = UDim2.new(sx, 0, 1, 6)
            local ex: number = sx + (math.random() - 0.5) * 0.08
            local dur: number = math.random(5, 9)
            Performance.Tween(b, { Position = UDim2.new(ex, 0, 0, -6) }, dur, Enum.EasingStyle.Linear).Completed:Connect(function()
                if b.Parent then
                    task.wait(math.random() * 1.2)
                    float()
                end
            end)
        end
        task.delay(math.random() * 2.5, float)
    end
end

function Window.new(cfg: WindowConfig): any
    cfg = cfg or {}

    local title: string    = cfg.Name or cfg.Title or "Animula"
    local subTitle: string = cfg.SubTitle or "Hydro Archon  •  Fontaine"
    if cfg.Author then
        subTitle = subTitle .. "  •  " .. cfg.Author
    end

    local icon: string?            = cfg.Icon
    local themeName: string?       = cfg.Theme
    -- responsive: kalo gak di set manual, auto nyesuain device
    -- riset: html 640px di HP 375px = 170% layar, jadi di HP kita pake scale
    local winSize: UDim2           = cfg.Size or Responsive.GetWindowSize()
    local draggable: boolean       = if cfg.Draggable == nil then true else cfg.Draggable
    local toggleKey: Enum.KeyCode? = cfg.ToggleKey or Enum.KeyCode.RightShift

    if themeName and Theme.Variants[themeName] then
        Theme:SetVariant(themeName)
    end

    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize
    local hui: Instance = Utils.getHui()

    -- === ScreenGui ===
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name           = "AnimulaUI_" .. HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 8)
    screenGui.ResetOnSpawn   = false
    screenGui.IgnoreGuiInset = true
    -- riset: ScreenInsets biar gak ketutup notch / dynamic island di HP
    pcall(function()
        (screenGui :: any).ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
        ;(screenGui :: any).ClipToDeviceSafeArea = true
    end)
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder   = 10
    screenGui.Parent         = hui
    -- UIScale biar proporsional di DPI beda (html rem vs roblox Offset)
    Responsive.AttachScale(screenGui)

    -- === Main Window ===
    local main = Instance.new("Frame")
    main.Name             = "MainWindow"
    main.BackgroundColor3 = T.Surface
    main.Size             = winSize
    main.Position         = UDim2.fromScale(0.5, 0.5)
    main.AnchorPoint      = Vector2.new(0.5, 0.5)
    main.ClipsDescendants = true -- biar wave gak keluar corner
    main.Parent           = screenGui
    Utils.Corner(main, R.Window)
    Utils.Stroke(main, T.Border, 1.5, 0.14)
    -- clamp biar gak kegedean / kekecilan di device aneh
    -- html gak ada ini, di html pake max-width / min-width
    Responsive.AttachConstraints(main)

    -- wave di belakang, transparan jadi cuma keliatan samar
    Wave.Attach(main, T)

    -- shadow - gw bikin 2 lapis biar lebih deep
    do
        local shadow1 = Instance.new("Frame")
        shadow1.Name                   = "Shadow1"
        shadow1.BackgroundColor3       = T.Shadow
        shadow1.BackgroundTransparency = 0.82
        shadow1.Size                   = UDim2.new(1, 18, 1, 18)
        shadow1.Position               = UDim2.fromOffset(-9, -9)
        shadow1.ZIndex                 = 0
        shadow1.BorderSizePixel        = 0
        shadow1.Parent                 = main
        local c1 = Instance.new("UICorner")
        c1.CornerRadius = UDim.new(0, 20)
        c1.Parent       = shadow1
        -- shadow kedua lebih soft
        local shadow2 = Instance.new("Frame")
        shadow2.Name                   = "Shadow2"
        shadow2.BackgroundColor3       = T.Primary
        shadow2.BackgroundTransparency = 0.92
        shadow2.Size                   = UDim2.new(1, 30, 1, 30)
        shadow2.Position               = UDim2.fromOffset(-15, -15)
        shadow2.ZIndex                 = -1
        shadow2.BorderSizePixel        = 0
        shadow2.Parent                 = main
        local c2 = Instance.new("UICorner")
        c2.CornerRadius = UDim.new(0, 24)
        c2.Parent       = shadow2
        main.ZIndex = 3
    end

    -- accent bar di atas - gradient 3 warna + shimmer
    do
        local bar = Instance.new("Frame")
        bar.Name             = "AccentBar"
        bar.BackgroundColor3 = T.Primary
        bar.Size             = UDim2.new(1, 0, 0, 3)
        bar.BorderSizePixel  = 0
        bar.ZIndex           = 8
        bar.Parent           = main
        Utils.Corner(bar, UDim.new(0, 99))
        -- gradient 3 warna biar lebih hidup
        local g = Instance.new("UIGradient")
        g.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0,   T.Primary),
            ColorSequenceKeypoint.new(0.5, T.Secondary),
            ColorSequenceKeypoint.new(1,   T.AccentGold),
        })
        g.Rotation = 0
        g.Parent   = bar
        local c: UICorner? = bar:FindFirstChildOfClass("UICorner") :: any
        if c then c.CornerRadius = UDim.new(0, 16) end

        -- shimmer jalan
        local shimmerGrad = Instance.new("UIGradient")
        shimmerGrad.Color = ColorSequence.new(Color3.new(1, 1, 1))
        shimmerGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.45, 0.5),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.55, 0.5),
            NumberSequenceKeypoint.new(1, 1),
        })
        shimmerGrad.Offset   = Vector2.new(-1, 0)
        shimmerGrad.Rotation = 10
        -- kita apply ke bar tapi pake overlay frame biar gak ngerusak gradient utama
        local shimmerFrame = Instance.new("Frame")
        shimmerFrame.BackgroundColor3       = Color3.new(1, 1, 1)
        shimmerFrame.BackgroundTransparency = 1
        shimmerFrame.Size                   = UDim2.fromScale(1, 1)
        shimmerFrame.BorderSizePixel        = 0
        shimmerFrame.ZIndex                 = 9
        shimmerFrame.Parent                 = bar
        local sc = Instance.new("UICorner")
        sc.CornerRadius = UDim.new(0, 99)
        sc.Parent       = shimmerFrame
        shimmerGrad.Parent = shimmerFrame
        task.spawn(function()
            while shimmerGrad.Parent do
                local tw = Performance.Tween(shimmerGrad, { Offset = Vector2.new(1, 0) }, 2.2, Enum.EasingStyle.Linear)
                tw.Completed:Wait()
                if not shimmerGrad.Parent then break end
                shimmerGrad.Offset = Vector2.new(-1, 0)
                task.wait(1.8)
            end
        end)
    end

    -- === TitleBar ===
    local titleBar = Instance.new("Frame")
    titleBar.Name                   = "TitleBar"
    titleBar.BackgroundTransparency = 1
    titleBar.Size                   = UDim2.new(1, 0, 0, 52)
    titleBar.Position               = UDim2.fromOffset(0, 3)
    titleBar.ZIndex                 = 6
    titleBar.Parent                 = main

    -- icon bulat - ada glow di belakangnya
    local iconWrap = Instance.new("Frame")
    iconWrap.Name             = "IconWrap"
    iconWrap.BackgroundColor3 = T.Primary
    iconWrap.Size             = UDim2.fromOffset(36, 36)
    iconWrap.Position         = UDim2.fromOffset(14, 8)
    iconWrap.ZIndex           = 7
    iconWrap.Parent           = titleBar
    Utils.Corner(iconWrap, UDim.new(1, 0))
    Utils.Gradient(iconWrap, T.Primary, T.Secondary, 35)

    -- glow di belakang icon
    do
        local glow = Instance.new("ImageLabel")
        glow.Name                   = "IconGlow"
        glow.BackgroundTransparency = 1
        glow.Image                  = "rbxassetid://5028857084"
        glow.ImageColor3            = T.Glow
        glow.ImageTransparency      = 0.55
        glow.ScaleType              = Enum.ScaleType.Slice
        glow.SliceCenter            = Rect.new(24, 24, 276, 276)
        glow.Size                   = UDim2.new(1, 18, 1, 18)
        glow.Position               = UDim2.fromOffset(-9, -9)
        glow.ZIndex                 = 6
        glow.Parent                 = iconWrap
        -- pulse pelan
        task.spawn(function()
            while glow.Parent do
                Performance.Tween(glow, { ImageTransparency = 0.75 }, 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
                if not glow.Parent then break end
                Performance.Tween(glow, { ImageTransparency = 0.45 }, 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
            end
        end)
    end

    -- ring tipis di icon biar premium
    do
        local ring = Instance.new("UIStroke")
        ring.Color       = T.AccentGold
        ring.Thickness   = 1.5
        ring.Transparency = 0.3
        ring.Parent      = iconWrap
    end

    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name                   = "Icon"
    iconLabel.BackgroundTransparency = 1
    iconLabel.Size                   = UDim2.fromScale(1, 1)
    iconLabel.FontFace               = F.Title
    iconLabel.TextSize               = 18
    iconLabel.TextColor3             = T.TextOnPrimary
    iconLabel.Text                   = "◈"
    iconLabel.ZIndex                 = 8
    iconLabel.Parent                 = iconWrap
    if icon and #icon <= 4 then
        iconLabel.Text = icon
    end

    -- title + subtitle
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name                   = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position               = UDim2.fromOffset(58, 6)
    titleLabel.Size                   = UDim2.new(1, -140, 0, 20)
    titleLabel.FontFace               = F.Title
    titleLabel.TextSize               = S.Title
    titleLabel.TextColor3             = T.Text
    titleLabel.TextXAlignment         = Enum.TextXAlignment.Left
    titleLabel.TextTruncate           = Enum.TextTruncate.AtEnd
    titleLabel.Text                   = title
    titleLabel.ZIndex                 = 7
    titleLabel.Parent                 = titleBar

    local subLabel = Instance.new("TextLabel")
    subLabel.Name                   = "SubTitle"
    subLabel.BackgroundTransparency = 1
    subLabel.Position               = UDim2.fromOffset(58, 26)
    subLabel.Size                   = UDim2.new(1, -140, 0, 14)
    subLabel.FontFace               = F.Body
    subLabel.TextSize               = S.Small
    subLabel.TextColor3             = T.TextDim
    subLabel.TextXAlignment         = Enum.TextXAlignment.Left
    subLabel.Text                   = subTitle
    subLabel.ZIndex                 = 7
    subLabel.Parent                 = titleBar

    -- === Window controls (min & close) ===
    local controls = Instance.new("Frame")
    controls.Name                   = "Controls"
    controls.BackgroundTransparency = 1
    controls.Size                   = UDim2.fromOffset(64, 32)
    controls.Position               = UDim2.new(1, -72, 0, 10)
    controls.ZIndex                 = 7
    controls.Parent                 = titleBar

    local ctrlLayout = Instance.new("UIListLayout")
    ctrlLayout.FillDirection       = Enum.FillDirection.Horizontal
    ctrlLayout.Padding             = UDim.new(0, 6)
    ctrlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ctrlLayout.Parent              = controls

    local function makeCtrlBtn(text: string, hover: Color3, cb: () -> ()): TextButton
        local b = Instance.new("TextButton")
        b.Name             = text
        b.BackgroundColor3 = T.SurfaceLight
        b.Size             = UDim2.fromOffset(28, 28)
        b.FontFace         = F.Body
        b.TextSize         = 14
        b.TextColor3       = T.TextDim
        b.Text             = text
        b.AutoButtonColor  = false
        b.ZIndex           = 7
        b.Parent           = controls
        Utils.Corner(b, UDim.new(0, 8))
        Utils.Stroke(b, T.Border, 1, 0.6)
        -- hover glow dikit
        b.MouseEnter:Connect(function()
            Performance.Tween(b, { BackgroundColor3 = hover }, 0.15)
            Performance.Tween(b, { TextColor3 = Color3.new(1, 1, 1) }, 0.15)
        end)
        b.MouseLeave:Connect(function()
            Performance.Tween(b, { BackgroundColor3 = T.SurfaceLight }, 0.15)
            Performance.Tween(b, { TextColor3 = T.TextDim }, 0.15)
        end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    -- === Body: Sidebar + Content ===
    local body = Instance.new("Frame")
    body.Name                   = "Body"
    body.BackgroundTransparency = 1
    body.Position               = UDim2.fromOffset(0, 56)
    body.Size                   = UDim2.new(1, 0, 1, -56)
    body.ZIndex                 = 4
    body.Parent                 = main

    -- sidebar
    local sidebar = Instance.new("ScrollingFrame")
    sidebar.Name                    = "Sidebar"
    sidebar.BackgroundColor3        = T.Background
    sidebar.BackgroundTransparency  = 0.22
    sidebar.Size                    = UDim2.new(0, 168, 1, -12)
    sidebar.Position                = UDim2.fromOffset(8, 6)
    sidebar.CanvasSize              = UDim2.fromOffset(0, 0)
    sidebar.ScrollBarThickness      = 2
    sidebar.ScrollBarImageColor3    = T.Primary
    sidebar.ScrollingDirection      = Enum.ScrollingDirection.Y
    sidebar.BorderSizePixel         = 0
    sidebar.ZIndex                  = 5
    sidebar.Parent                  = body
    Utils.Corner(sidebar, R.Large)
    Utils.Stroke(sidebar, T.Border, 1, 0.45)
    Utils.Padding(sidebar, 6, 8, 6, 8)

    local sideList = Instance.new("UIListLayout")
    sideList.FillDirection = Enum.FillDirection.Vertical
    sideList.Padding       = UDim.new(0, 4)
    sideList.SortOrder     = Enum.SortOrder.LayoutOrder
    sideList.Parent        = sidebar

    -- collapse sidebar di HP biar gak sempit
    local isPhone: boolean = Responsive.ShouldCollapseSidebar()
    local sidebarW: number = if isPhone then 0 else 168
    local contentX: number = if isPhone then 8 else 176
    local contentW: number = if isPhone then -16 else -184
    if isPhone then
        sidebar.Visible = false -- di HP hidden, nanti bisa di toggle hamburger
    end

    -- content wrapper - glass effect dikit
    local contentWrap = Instance.new("Frame")
    contentWrap.Name                     = "ContentWrap"
    contentWrap.BackgroundColor3         = T.SurfaceLight
    contentWrap.BackgroundTransparency   = 0.08
    contentWrap.Size                     = UDim2.new(1, contentW, 1, -12)
    contentWrap.Position                 = UDim2.new(0, contentX, 0, 6)
    contentWrap.ZIndex                   = 5
    contentWrap.Parent                   = body
    Utils.Corner(contentWrap, R.Large)
    -- border nya agak glowing
    do
        local st = Utils.Stroke(contentWrap, T.Border, 1, 0.38)
        -- inner highlight atas (kayak glass reflection)
        local hl = Instance.new("Frame")
        hl.Name                   = "Highlight"
        hl.BackgroundColor3       = Color3.new(1, 1, 1)
        hl.BackgroundTransparency = 0.94
        hl.Size                   = UDim2.new(1, -2, 0, 1)
        hl.Position               = UDim2.fromOffset(1, 1)
        hl.BorderSizePixel        = 0
        hl.ZIndex                 = 6
        hl.Parent                 = contentWrap
    end

    -- particle bubble di contentWrap biar hidup
    -- jangan lupa clipping biar gak keluar
    contentWrap.ClipsDescendants = true
    Bubbles.Spawn(contentWrap)

    local contentScroll = Instance.new("ScrollingFrame")
    contentScroll.Name                     = "Content"
    contentScroll.BackgroundTransparency   = 1
    contentScroll.Size                     = UDim2.fromScale(1, 1)
    contentScroll.CanvasSize               = UDim2.fromOffset(0, 0)
    contentScroll.ScrollBarThickness       = 3
    contentScroll.ScrollBarImageColor3     = T.Primary
    contentScroll.ScrollBarImageTransparency = 0.3
    contentScroll.BorderSizePixel          = 0
    contentScroll.ZIndex                   = 6
    contentScroll.Parent                   = contentWrap
    Utils.Padding(contentScroll, 14, 14, 14, 14)

    local contentList = Instance.new("UIListLayout")
    contentList.FillDirection = Enum.FillDirection.Vertical
    contentList.Padding       = UDim.new(0, 10)
    contentList.SortOrder     = Enum.SortOrder.LayoutOrder
    contentList.Parent        = contentScroll

    -- anti-lag: debounced canvas
    local pool: any = Performance.NewPool()
    pool:Add(Performance.AutoCanvas(sidebar, sideList, 24))
    pool:Add(Performance.AutoCanvas(contentScroll, contentList, 24))

    -- === Window object ===
    local self: any = setmetatable({}, Window)
    self._gui       = screenGui
    self._main      = main
    self._sidebar   = sidebar
    self._content   = contentScroll
    self._titleLbl  = titleLabel
    self._subLbl    = subLabel
    self._wrap      = contentWrap
    self._body      = body
    self._pool      = pool
    self._tabs      = {}
    self._activeTab = nil
    self._visible   = true
    self._winSize   = winSize
    self._closeCb   = cfg.CloseCallback
    self._T         = T
    self._R         = R
    self._F         = F
    self._S         = S

    if cfg.SaveConfig and cfg.ConfigFolder then
        self._configFolder = cfg.ConfigFolder
        Config:LoadFromFile(cfg.ConfigFolder, "config")
    end

    -- controls
    local minimized: boolean = false
    makeCtrlBtn("—", T.SurfaceHover, function()
        minimized = not minimized
        if minimized then
            Performance.Tween(body, { Size = UDim2.new(1, 0, 0, 0) }, 0.22)
            Performance.Tween(main, { Size = UDim2.fromOffset(winSize.X.Offset, 56) }, 0.22)
        else
            Performance.Tween(body, { Size = UDim2.new(1, 0, 1, -56) }, 0.22)
            Performance.Tween(main, { Size = winSize }, 0.22)
        end
    end)
    makeCtrlBtn("✕", Color3.fromRGB(220, 60, 60), function()
        self:Destroy()
        if self._closeCb then task.spawn(self._closeCb) end
    end)

    if draggable then
        Utils.MakeDraggable(titleBar, main)
    end

    if toggleKey then
        local conn: RBXScriptConnection =
            UserInputService.InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.KeyCode == toggleKey then self:Toggle() end
            end)
        pool:Add(conn)
    end

    -- entrance - scale + fade, biar pop
    main.Size                   = UDim2.fromOffset(winSize.X.Offset - 28, winSize.Y.Offset - 28)
    main.BackgroundTransparency = 0.2
    -- scale dikit dulu terus balik
    Performance.Tween(main, { Size = winSize }, 0.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    Performance.Tween(main, { BackgroundTransparency = 0 }, 0.24)

    return self
end

function Window:SetTitle(newTitle: string, newSub: string?)
    (self._titleLbl :: TextLabel).Text = newTitle
    if newSub then
        (self._subLbl :: TextLabel).Text = newSub
    end
end

function Window:SetTheme(name: string)
    if not Theme.Variants[name] then return end
    Theme:SetVariant(name)
    local T = Theme.Current
    self._T = T
    ;(self._main :: Frame).BackgroundColor3                 = T.Surface
    ;(self._sidebar :: ScrollingFrame).BackgroundColor3     = T.Background
    ;(self._wrap :: Frame).BackgroundColor3                 = T.SurfaceLight
    ;(self._titleLbl :: TextLabel).TextColor3               = T.Text
    ;(self._subLbl :: TextLabel).TextColor3                 = T.TextDim
    ;(self._content :: ScrollingFrame).ScrollBarImageColor3 = T.Primary
    ;(self._sidebar :: ScrollingFrame).ScrollBarImageColor3 = T.Primary
end

function Window:Toggle(state: boolean?)
    local show: boolean = if state == nil then not self._visible else (state :: boolean)
    self._visible = show
    if show then
        (self._gui :: ScreenGui).Enabled = true
        ;(self._main :: Frame).Visible   = true
        Performance.Tween(self._main, { BackgroundTransparency = 0 }, 0.2)
        ;(self._main :: Frame).Size = UDim2.fromOffset(
            (self._winSize :: UDim2).X.Offset - 16,
            (self._winSize :: UDim2).Y.Offset - 16
        )
        Performance.Tween(self._main, { Size = self._winSize }, 0.3, Enum.EasingStyle.Back)
    else
        Performance.Tween(self._main, { BackgroundTransparency = 1 }, 0.18)
        task.delay(0.18, function()
            if not self._visible then
                (self._main :: Frame).Visible = false
            end
        end)
    end
end

function Window:Destroy()
    if self._pool then (self._pool :: any):Clear() end
    (self._gui :: ScreenGui):Destroy()
end

function Window:Notify(cfg: any)
    local ok, mod = pcall(function() return __require("Notification") end)
    local N: any = (ok and mod) or __require("Notification")
    return N.Notify(cfg)
end
function Window:MakeNotification(cfg: any) return self:Notify(cfg) end
function Window:Dialog(cfg: any)
    local ok, mod = pcall(function() return __require("Notification") end)
    local N: any = (ok and mod) or __require("Notification")
    return N.Dialog(cfg, self._main)
end
function Window:Popup(cfg: any)
    local ok, mod = pcall(function() return __require("Notification") end)
    local N: any = (ok and mod) or __require("Notification")
    return N.Popup(cfg)
end

return Window
end)()

-- ===== ComponentsUI/Notification/Toast/Toast.lua (Toast) =====
__mods["Toast"] = (function()
-- Notification/Toast/Toast.lua - toast notification (pojok kanan bawah)
-- ada queue limit 5 biar gak spam, anti-lag

local Theme       = __require("AnimulaTheme")
local Utils       = __require("Utils")
local Performance = __require("Performance")

local Toast = {}

local gui: ScreenGui? = nil
local container: Frame? = nil

local function ensureGui(): (ScreenGui, Frame)
    if gui and gui.Parent and container then
        return gui :: ScreenGui, container :: Frame
    end

    local hui = Utils.getHui()

    local sg = Instance.new("ScreenGui")
    sg.Name           = "AnimulaUI_Notifications"
    sg.ResetOnSpawn   = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder   = 9999
    sg.Parent         = hui

    local c = Instance.new("Frame")
    c.Name                  = "Container"
    c.BackgroundTransparency = 1
    c.Size                  = UDim2.fromScale(1, 1)
    c.Parent                = sg

    local list = Instance.new("UIListLayout")
    list.FillDirection       = Enum.FillDirection.Vertical
    list.HorizontalAlignment = Enum.HorizontalAlignment.Right
    list.VerticalAlignment   = Enum.VerticalAlignment.Bottom
    list.Padding             = UDim.new(0, 8)
    list.SortOrder           = Enum.SortOrder.LayoutOrder
    list.Parent              = c
    Utils.Padding(c, 0, 0, 16, 16)

    gui = sg
    container = c
    return sg, c
end

function Toast.Notify(cfg: any): Frame
    cfg = cfg or {}
    local title: string = cfg.Title or cfg.Name or "Notification"
    local desc: string  = cfg.Desc  or cfg.Description or cfg.Content or ""
    local duration: number = cfg.Duration or cfg.Time or 3
    local ntype: string = cfg.Type or "Info"

    local _, cont = ensureGui()
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local colorMap: { [string]: Color3 } = {
        Info = T.Info, Success = T.Success, Warning = T.Warning, Error = T.Error,
    }
    local accent: Color3 = (colorMap :: any)[ntype] or T.Primary

    local toast = Instance.new("Frame")
    toast.BackgroundColor3 = T.Surface
    toast.Size             = UDim2.fromOffset(300, if desc ~= "" then 72 else 52)
    toast.Parent           = cont
    Utils.Corner(toast, R.Medium)
    Utils.Stroke(toast, T.Border, 1, 0.35)
    toast.ClipsDescendants = true

    local bar = Instance.new("Frame")
    bar.BackgroundColor3 = accent
    bar.Size             = UDim2.fromOffset(4, 999)
    bar.BorderSizePixel  = 0
    bar.Parent           = toast

    local t1 = Instance.new("TextLabel")
    t1.BackgroundTransparency = 1
    t1.Position   = UDim2.fromOffset(14, 10)
    t1.Size       = UDim2.new(1, -28, 0, 16)
    t1.FontFace   = F.Heading
    t1.TextSize   = S.Body
    t1.TextColor3 = T.Text
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Text       = title
    t1.Parent     = toast

    if desc ~= "" then
        local t2 = Instance.new("TextLabel")
        t2.BackgroundTransparency = 1
        t2.Position   = UDim2.fromOffset(14, 28)
        t2.Size       = UDim2.new(1, -28, 0, 28)
        t2.FontFace   = F.Body
        t2.TextSize   = S.Small
        t2.TextColor3 = T.TextDim
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextYAlignment = Enum.TextYAlignment.Top
        t2.TextWrapped = true
        t2.Text        = desc
        t2.Parent      = toast
    end

    if cfg.Image and string.match(cfg.Image, "^rbxassetid://") then
        local img = Instance.new("ImageLabel")
        img.BackgroundTransparency = 1
        img.Size     = UDim2.fromOffset(20, 20)
        img.Position = UDim2.fromOffset(276, 10)
        img.Image    = cfg.Image
        img.Parent   = toast
    end

    Performance.EnforceLimit(cont, Performance.NotifyLimit)
    toast.Position = UDim2.new(0, 320, 0, 0)
    Performance.Tween(toast, { Position = UDim2.fromOffset(0, 0) }, 0.32, Enum.EasingStyle.Back)

    task.delay(duration, function()
        if toast.Parent then
            Performance.Tween(toast, { Position = UDim2.new(0, 320, 0, 0) }, 0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            task.wait(0.24)
            toast:Destroy()
        end
    end)

    return toast
end

return Toast
end)()

-- ===== ComponentsUI/Notification/Dialog/Dialog.lua (Dialog) =====
__mods["Dialog"] = (function()
-- Notification/Dialog/Dialog.lua - modal dialog di tengah window

local Theme       = __require("AnimulaTheme")
local Utils       = __require("Utils")
local Performance = __require("Performance")

local Dialog = {}

function Dialog.Show(cfg: any, parentWindow: Frame?): any
    cfg = cfg or {}
    local title: string = cfg.Title or cfg.Name or "Dialog"
    local desc: string  = cfg.Desc  or cfg.Description or cfg.Content or ""
    local buttons: any  = cfg.Buttons or cfg.Options or {
        { Title = "Cancel",  Variant = "Secondary" },
        { Title = "Confirm", Variant = "Primary", Callback = cfg.Callback },
    }

    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize
    local hui = Utils.getHui()
    local isChild = parentWindow ~= nil
    local overlay: Frame
    local sg: Instance

    if isChild then
        sg = parentWindow :: Frame
        overlay = Instance.new("Frame")
        overlay.Name                  = "DialogOverlay"
        overlay.BackgroundColor3      = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 0.45
        overlay.Size                  = UDim2.fromScale(1, 1)
        overlay.ZIndex                = 50
        overlay.Parent                = parentWindow
    else
        local s = Instance.new("ScreenGui")
        s.Name           = "AnimulaUI_Dialog"
        s.ResetOnSpawn   = false
        s.IgnoreGuiInset = true
        s.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        s.DisplayOrder   = 100
        s.Parent         = hui
        sg = s
        overlay = Instance.new("Frame")
        overlay.BackgroundColor3      = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 0.45
        overlay.Size                  = UDim2.fromScale(1, 1)
        overlay.Parent                = s
    end

    local dialog = Instance.new("Frame")
    dialog.BackgroundColor3 = T.Surface
    dialog.Size             = UDim2.fromOffset(360, 180)
    dialog.Position         = UDim2.fromScale(0.5, 0.5)
    dialog.AnchorPoint      = Vector2.new(0.5, 0.5)
    dialog.Parent           = overlay
    Utils.Corner(dialog, R.Large)
    Utils.Stroke(dialog, T.Border, 1, 0.25)

    local t1 = Instance.new("TextLabel")
    t1.BackgroundTransparency = 1
    t1.Position   = UDim2.fromOffset(18, 16)
    t1.Size       = UDim2.new(1, -36, 0, 20)
    t1.FontFace   = F.Title
    t1.TextSize   = S.Title - 1
    t1.TextColor3 = T.Text
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Text       = title
    t1.Parent     = dialog

    local t2 = Instance.new("TextLabel")
    t2.BackgroundTransparency = 1
    t2.Position   = UDim2.fromOffset(18, 42)
    t2.Size       = UDim2.new(1, -36, 0, 60)
    t2.FontFace   = F.Body
    t2.TextSize   = S.Small
    t2.TextColor3 = T.TextDim
    t2.TextXAlignment = Enum.TextXAlignment.Left
    t2.TextYAlignment = Enum.TextYAlignment.Top
    t2.TextWrapped = true
    t2.Text        = desc
    t2.Parent      = dialog

    local row = Instance.new("Frame")
    row.BackgroundTransparency = 1
    row.Size     = UDim2.new(1, -36, 0, 32)
    row.Position = UDim2.new(0, 18, 1, -44)
    row.Parent   = dialog

    local rowList = Instance.new("UIListLayout")
    rowList.FillDirection       = Enum.FillDirection.Horizontal
    rowList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    rowList.Padding             = UDim.new(0, 8)
    rowList.Parent              = row

    local function close()
        Performance.Tween(dialog,  { BackgroundTransparency = 1 }, 0.14)
        Performance.Tween(overlay, { BackgroundTransparency = 1 }, 0.14)
        task.wait(0.15)
        if isChild then overlay:Destroy()
        else (sg :: ScreenGui):Destroy() end
    end

    for _, b in ipairs(buttons) do
        local bTitle: string = b.Title or b.Text or "OK"
        local variant: string = b.Variant or "Secondary"
        local cb: (() -> ())? = b.Callback
        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = if variant == "Primary" then T.Primary else T.SurfaceLight
        btn.Size             = UDim2.fromOffset(84, 32)
        btn.FontFace         = F.Heading
        btn.TextSize         = S.Small
        btn.TextColor3       = if variant == "Primary" then T.TextOnPrimary else T.Text
        btn.Text             = bTitle
        btn.AutoButtonColor  = false
        btn.Parent           = row
        Utils.Corner(btn, R.Small)
        if variant == "Primary" then Utils.Gradient(btn, T.Primary, T.PrimaryDark, 90)
        else Utils.Stroke(btn, T.Border, 1, 0.4) end
        btn.MouseButton1Click:Connect(function()
            if cb then task.spawn(cb) end
            close()
        end)
    end

    dialog.Size = UDim2.fromOffset(340, 170)
    Performance.Tween(dialog, { Size = UDim2.fromOffset(360, 180) }, 0.24, Enum.EasingStyle.Back)

    return { Close = close, Frame = dialog }
end

return Dialog
end)()

-- ===== ComponentsUI/Notification/Popup/Popup.lua (Popup) =====
__mods["Popup"] = (function()
-- Notification/Popup/Popup.lua - floating popup kecil

local Theme       = __require("AnimulaTheme")
local Utils       = __require("Utils")
local Performance = __require("Performance")

local Popup = {}

function Popup.Show(cfg: any): any
    cfg = cfg or {}
    local title: string = cfg.Title or cfg.Name or "Popup"
    local desc: string  = cfg.Desc  or cfg.Description or cfg.Content or ""
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize
    local hui = Utils.getHui()

    local sg = Instance.new("ScreenGui")
    sg.Name           = "AnimulaUI_Popup"
    sg.ResetOnSpawn   = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder   = 90
    sg.Parent         = hui

    local popup = Instance.new("Frame")
    popup.BackgroundColor3 = T.Surface
    popup.Size     = UDim2.fromOffset(320, 140)
    popup.Position = UDim2.fromScale(0.5, 0.5)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.Parent   = sg
    Utils.Corner(popup, R.Large)
    Utils.Stroke(popup, T.Border, 1, 0.3)

    local t1 = Instance.new("TextLabel")
    t1.BackgroundTransparency = 1
    t1.Position   = UDim2.fromOffset(16, 12)
    t1.Size       = UDim2.new(1, -32, 0, 18)
    t1.FontFace   = F.Title
    t1.TextSize   = 14
    t1.TextColor3 = T.Text
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Text       = title
    t1.Parent     = popup

    if desc ~= "" then
        local d = Instance.new("TextLabel")
        d.BackgroundTransparency = 1
        d.Position   = UDim2.fromOffset(16, 34)
        d.Size       = UDim2.new(1, -32, 0, 60)
        d.FontFace   = F.Body
        d.TextSize   = S.Small
        d.TextColor3 = T.TextDim
        d.TextWrapped = true
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.TextYAlignment = Enum.TextYAlignment.Top
        d.Text        = desc
        d.Parent      = popup
    end

    local closeBtn = Instance.new("TextButton")
    closeBtn.BackgroundColor3 = T.SurfaceLight
    closeBtn.Size     = UDim2.fromOffset(24, 24)
    closeBtn.Position = UDim2.new(1, -32, 0, 8)
    closeBtn.FontFace = F.Body
    closeBtn.TextSize = 12
    closeBtn.TextColor3 = T.TextMuted
    closeBtn.Text     = "x"
    closeBtn.Parent   = popup
    Utils.Corner(closeBtn, UDim.new(1, 0))

    local function close()
        Performance.Tween(popup, { BackgroundTransparency = 1 }, 0.16)
        task.wait(0.16)
        sg:Destroy()
    end
    closeBtn.MouseButton1Click:Connect(close)
    task.delay(cfg.Duration or 4, close)
    return { Close = close }
end

return Popup
end)()

-- ===== ComponentsUI/Notification/Notification.lua (Notification) =====
__mods["Notification"] = (function()
local Toast  = __require("Toast")
local Dialog = __require("Dialog")
local Popup  = __require("Popup")
local Notification = {}
function Notification.Notify(cfg: any) return Toast.Notify(cfg) end
Notification.MakeNotification = Notification.Notify
function Notification.Dialog(cfg: any, parent: Frame?) return Dialog.Show(cfg, parent) end
function Notification.Popup(cfg: any) return Popup.Show(cfg) end
return Notification
end)()

-- ===== ComponentsUI/Tabs/TabManager.lua (TabManager) =====
__mods["TabManager"] = (function()
-- TabManager.lua - attach tabs ke window (modular)
-- sekarang elements di split per-file di Elements/Button, Toggle, dll
-- jadi ComponentsUI keliatan rapih, gak numpuk 1000 baris di satu file wkwk

local Theme = __require("AnimulaTheme")
local Utils = __require("Utils")

-- inject elements dari file terpisah
local function injectElements(Tab: any, page: Frame)
    -- helper card dipass ke tiap element via Apply
    -- tiap element punya file sendiri: Elements/Button/Button.lua dll
    local Config = __require("Config")  -- bundled patch

    local function tryApply(folder: string, file: string)
        local ok, mod = pcall(function()
            local folderInst = base:FindFirstChild(folder)
            if not folderInst then return nil end
            local fileInst = folderInst:FindFirstChild(file)
            if not fileInst then return nil end
            return require(fileInst)
        end)
        if ok and mod and mod.Apply then
            local ok2, err = pcall(function()
                mod.Apply(Tab, page, Theme, Utils, __require("Config"))
            end)
            if not ok2 then
                warn("[AnimulaUI] gagal load element " .. folder .. "/" .. file .. ": " .. tostring(err))
            end
        elseif not ok then
            warn("[AnimulaUI] require gagal " .. folder .. "/" .. file)
        end
    end

    tryApply("Label", "Label")
    tryApply("Paragraph", "Paragraph")
    tryApply("Section", "Section")
    tryApply("Divider", "Divider")
    tryApply("Button", "Button")
    tryApply("Toggle", "Toggle")
    tryApply("Slider", "Slider")
    tryApply("Dropdown", "Dropdown")
    tryApply("Textbox", "Textbox")
    tryApply("ColorPicker", "ColorPicker")
    tryApply("Keybind", "Keybind")
end

local TabManager = {}

function TabManager.Attach(window: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local sidebar       = window._sidebar       :: ScrollingFrame
    local contentScroll = window._content       :: ScrollingFrame

    local function makeTab(tabConfig: any): any
        tabConfig = tabConfig or {}
        local tabTitle: string = tabConfig.Name or tabConfig.Title or ("Tab " .. tostring(#window._tabs + 1))
        local tabIcon: string? = tabConfig.Icon
        local isDefault: boolean = tabConfig.Default == true or #window._tabs == 0

        local tabBtn = Instance.new("TextButton")
        tabBtn.Name                  = tabTitle
        tabBtn.BackgroundColor3      = T.SurfaceLight
        tabBtn.BackgroundTransparency = 0.4
        tabBtn.Size                  = UDim2.new(1, 0, 0, 36)
        tabBtn.AutoButtonColor       = false
        tabBtn.Text                  = ""
        tabBtn.Parent                = sidebar
        Utils.Corner(tabBtn, R.Medium)
        Utils.Stroke(tabBtn, T.Border, 1, 0.55)

        local tabIconLbl = Instance.new("TextLabel")
        tabIconLbl.BackgroundTransparency = 1
        tabIconLbl.Size       = UDim2.fromOffset(28, 28)
        tabIconLbl.Position   = UDim2.fromOffset(6, 4)
        tabIconLbl.FontFace   = F.Body
        tabIconLbl.TextSize   = 14
        tabIconLbl.TextColor3 = T.TextDim
        tabIconLbl.Text = if tabIcon then (if #tabIcon <= 4 then tabIcon else "◇") else "◇"
        tabIconLbl.Parent = tabBtn

        if tabIcon and string.match(tabIcon, "^rbxassetid://") then
            local img = Instance.new("ImageLabel")
            img.BackgroundTransparency = 1
            img.Size     = UDim2.fromOffset(20, 20)
            img.Position = UDim2.fromOffset(8, 8)
            img.Image    = tabIcon
            img.Parent   = tabBtn
            tabIconLbl.Visible = false
        end

        local tabText = Instance.new("TextLabel")
        tabText.BackgroundTransparency = 1
        tabText.Position   = UDim2.fromOffset(34, 0)
        tabText.Size       = UDim2.new(1, -40, 1, 0)
        tabText.FontFace   = F.Heading
        tabText.TextSize   = S.Body
        tabText.TextColor3 = T.TextDim
        tabText.TextXAlignment = Enum.TextXAlignment.Left
        tabText.Text       = tabTitle
        tabText.Parent     = tabBtn

        local page = Instance.new("Frame")
        page.Name            = "Page_" .. tabTitle
        page.BackgroundTransparency = 1
        page.Size            = UDim2.new(1, 0, 0, 0)
        page.AutomaticSize   = Enum.AutomaticSize.Y
        page.Visible         = false
        page.Parent          = contentScroll

        local pageList = Instance.new("UIListLayout")
        pageList.FillDirection = Enum.FillDirection.Vertical
        pageList.Padding       = UDim.new(0, 10)
        pageList.SortOrder     = Enum.SortOrder.LayoutOrder
        pageList.Parent        = page

        local Tab: any = {}
        Tab._btn  = tabBtn
        Tab._page = page
        Tab.Name  = tabTitle
        Tab.Title = tabTitle

        local function setActive(active: boolean)
            if active then
                Utils.Tween(tabBtn,     { BackgroundColor3 = T.Primary }, 0.18)
                Utils.Tween(tabText,    { TextColor3 = T.TextOnPrimary }, 0.18)
                Utils.Tween(tabIconLbl, { TextColor3 = T.TextOnPrimary }, 0.18)
                tabBtn.BackgroundTransparency = 0
                local st = tabBtn:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.PrimaryLight end
            else
                Utils.Tween(tabBtn,     { BackgroundColor3 = T.SurfaceLight }, 0.18)
                Utils.Tween(tabText,    { TextColor3 = T.TextDim }, 0.18)
                Utils.Tween(tabIconLbl, { TextColor3 = T.TextDim }, 0.18)
                tabBtn.BackgroundTransparency = 0.4
                local st = tabBtn:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.Border end
            end
        end

        function Tab:Select()
            for _, t in ipairs(window._tabs) do
                t._page.Visible = false
                local b = t._btn :: TextButton
                local st = b:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.Border end
                b.BackgroundColor3       = T.SurfaceLight
                b.BackgroundTransparency = 0.4
                for _, ch in ipairs(b:GetChildren()) do
                    if ch:IsA("TextLabel") then (ch :: TextLabel).TextColor3 = T.TextDim end
                end
            end
            page.Visible      = true
            window._activeTab = Tab
            setActive(true)
            task.defer(function() contentScroll.CanvasPosition = Vector2.zero end)
        end

        tabBtn.MouseButton1Click:Connect(function() Tab:Select() end)
        tabBtn.MouseEnter:Connect(function()
            if window._activeTab ~= Tab then Utils.Tween(tabBtn, { BackgroundColor3 = T.SurfaceHover }, 0.12) end
        end)
        tabBtn.MouseLeave:Connect(function()
            if window._activeTab ~= Tab then Utils.Tween(tabBtn, { BackgroundColor3 = T.SurfaceLight }, 0.12) end
        end)

        injectElements(Tab, page)

        table.insert(window._tabs, Tab)
        if isDefault then Tab:Select() end
        return Tab
    end

    window.MakeTab = makeTab
    window.Tab     = makeTab
    window.AddTab  = makeTab
end

return TabManager
end)()

-- ===== ComponentsUI/Tabs/Manager/Manager.lua (Manager) =====
__mods["Manager"] = (function()
-- Tabs/Manager/Manager.lua - attach tabs ke window
-- sebelumnya ini di TabManager.lua, sekarang dipisah biar rapih

local Theme = __require("AnimulaTheme")
local Utils = __require("Utils")

local Manager = {}

-- inject semua elements ke Tab (Button, Toggle, Slider, dll)
local function injectElements(Tab: any, page: Frame)
-- (bundled) dynamic Elements require handled via __mods El*
    local function load(name: string, folder: string)
        local ok, mod = pcall(function()
            return require(base:FindFirstChild(folder):FindFirstChild(name))
        end)
        if ok and mod and mod.Apply then
            mod.Apply(Tab, page, Theme, Utils, require(base.Parent.Core.Config))
        end
    end
    -- urutan penting: Label dulu baru yg lain
    load("Label", "Label")
    load("Paragraph", "Paragraph")
    load("Section", "Section")
    load("Divider", "Divider")
    load("Button", "Button")
    load("Toggle", "Toggle")
    load("Slider", "Slider")
    load("Dropdown", "Dropdown")
    load("Textbox", "Textbox")
    load("ColorPicker", "ColorPicker")
    load("Keybind", "Keybind")
end

function Manager.Attach(window: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize
    local sidebar       = window._sidebar       :: ScrollingFrame
    local contentScroll = window._content       :: ScrollingFrame

    local function makeTab(tabConfig: any): any
        tabConfig = tabConfig or {}
        local tabTitle: string = tabConfig.Name or tabConfig.Title or ("Tab " .. tostring(#window._tabs + 1))
        local tabIcon: string? = tabConfig.Icon
        local isDefault: boolean = tabConfig.Default == true or #window._tabs == 0

        local tabBtn = Instance.new("TextButton")
        tabBtn.Name                  = tabTitle
        tabBtn.BackgroundColor3      = T.SurfaceLight
        tabBtn.BackgroundTransparency = 0.4
        tabBtn.Size                  = UDim2.new(1, 0, 0, 36)
        tabBtn.AutoButtonColor       = false
        tabBtn.Text                  = ""
        tabBtn.Parent                = sidebar
        Utils.Corner(tabBtn, R.Medium)
        Utils.Stroke(tabBtn, T.Border, 1, 0.55)

        local tabIconLbl = Instance.new("TextLabel")
        tabIconLbl.BackgroundTransparency = 1
        tabIconLbl.Size       = UDim2.fromOffset(28, 28)
        tabIconLbl.Position   = UDim2.fromOffset(6, 4)
        tabIconLbl.FontFace   = F.Body
        tabIconLbl.TextSize   = 14
        tabIconLbl.TextColor3 = T.TextDim
        tabIconLbl.Text = if tabIcon then (if #tabIcon <= 4 then tabIcon else "◇") else "◇"
        tabIconLbl.Parent = tabBtn

        if tabIcon and string.match(tabIcon, "^rbxassetid://") then
            local img = Instance.new("ImageLabel")
            img.BackgroundTransparency = 1
            img.Size     = UDim2.fromOffset(20, 20)
            img.Position = UDim2.fromOffset(8, 8)
            img.Image    = tabIcon
            img.Parent   = tabBtn
            tabIconLbl.Visible = false
        end

        local tabText = Instance.new("TextLabel")
        tabText.BackgroundTransparency = 1
        tabText.Position   = UDim2.fromOffset(34, 0)
        tabText.Size       = UDim2.new(1, -40, 1, 0)
        tabText.FontFace   = F.Heading
        tabText.TextSize   = S.Body
        tabText.TextColor3 = T.TextDim
        tabText.TextXAlignment = Enum.TextXAlignment.Left
        tabText.Text       = tabTitle
        tabText.Parent     = tabBtn

        local page = Instance.new("Frame")
        page.Name            = "Page_" .. tabTitle
        page.BackgroundTransparency = 1
        page.Size            = UDim2.new(1, 0, 0, 0)
        page.AutomaticSize   = Enum.AutomaticSize.Y
        page.Visible         = false
        page.Parent          = contentScroll

        local pageList = Instance.new("UIListLayout")
        pageList.FillDirection = Enum.FillDirection.Vertical
        pageList.Padding       = UDim.new(0, 10)
        pageList.SortOrder     = Enum.SortOrder.LayoutOrder
        pageList.Parent        = page

        local Tab: any = {}
        Tab._btn  = tabBtn
        Tab._page = page
        Tab.Name  = tabTitle
        Tab.Title = tabTitle

        local function setActive(active: boolean)
            if active then
                Utils.Tween(tabBtn,     { BackgroundColor3 = T.Primary }, 0.18)
                Utils.Tween(tabText,    { TextColor3 = T.TextOnPrimary }, 0.18)
                Utils.Tween(tabIconLbl, { TextColor3 = T.TextOnPrimary }, 0.18)
                tabBtn.BackgroundTransparency = 0
                local st = tabBtn:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.PrimaryLight end
            else
                Utils.Tween(tabBtn,     { BackgroundColor3 = T.SurfaceLight }, 0.18)
                Utils.Tween(tabText,    { TextColor3 = T.TextDim }, 0.18)
                Utils.Tween(tabIconLbl, { TextColor3 = T.TextDim }, 0.18)
                tabBtn.BackgroundTransparency = 0.4
                local st = tabBtn:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.Border end
            end
        end

        function Tab:Select()
            for _, t in ipairs(window._tabs) do
                t._page.Visible = false
                local b = t._btn :: TextButton
                local st = b:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.Border end
                b.BackgroundColor3       = T.SurfaceLight
                b.BackgroundTransparency = 0.4
                for _, ch in ipairs(b:GetChildren()) do
                    if ch:IsA("TextLabel") then (ch :: TextLabel).TextColor3 = T.TextDim end
                end
            end
            page.Visible      = true
            window._activeTab = Tab
            setActive(true)
            task.defer(function() contentScroll.CanvasPosition = Vector2.zero end)
        end

        tabBtn.MouseButton1Click:Connect(function() Tab:Select() end)
        tabBtn.MouseEnter:Connect(function()
            if window._activeTab ~= Tab then Utils.Tween(tabBtn, { BackgroundColor3 = T.SurfaceHover }, 0.12) end
        end)
        tabBtn.MouseLeave:Connect(function()
            if window._activeTab ~= Tab then Utils.Tween(tabBtn, { BackgroundColor3 = T.SurfaceLight }, 0.12) end
        end)

        injectElements(Tab, page)

        table.insert(window._tabs, Tab)
        if isDefault then Tab:Select() end
        return Tab
    end

    window.MakeTab = makeTab
    window.Tab     = makeTab
    window.AddTab  = makeTab
end

return Manager
end)()


-- ===== LoaderUI API (bundled) =====
do
    local Theme        = __mods["AnimulaTheme"]
    local Config       = __mods["Config"]
    local WindowMod    = __mods["WindowMod"]
    local TabManager   = __mods["TabManager"]
    local Notification = __mods["Notification"]

    local AnimulaUI = {}
    AnimulaUI.Version = "2.2.0-rapih-bundled"
    AnimulaUI.Theme   = Theme
    AnimulaUI.Config  = Config
    AnimulaUI.Flags   = Config.Flags

    function AnimulaUI:MakeWindow(cfg)
        local win = WindowMod.new(cfg or {})
        TabManager.Attach(win)
        return win
    end
    AnimulaUI.CreateWindow = AnimulaUI.MakeWindow

    function AnimulaUI:MakeNotification(cfg) return Notification.Notify(cfg) end
    function AnimulaUI:Notify(cfg) return Notification.Notify(cfg) end
    function AnimulaUI:Dialog(cfg, p) return Notification.Dialog(cfg, p) end
    function AnimulaUI:Popup(cfg) return Notification.Popup(cfg) end
    function AnimulaUI:Init() return end
    function AnimulaUI:Destroy()
        local ok, hui = pcall(function() return (gethui and gethui()) end)
        local root = nil
        if ok and typeof(hui) == "Instance" then root = hui
        else
            local lp = game:GetService("Players").LocalPlayer
            root = lp and lp:FindFirstChildOfClass("PlayerGui")
        end
        if not root then return end
        for _, ch in ipairs(root:GetChildren()) do
            if ch:IsA("ScreenGui") and string.match(ch.Name, "^AnimulaUI") then ch:Destroy() end
        end
    end
    function AnimulaUI:SetTheme(name) Theme:SetVariant(name) end

    AnimulaUI.Responsive = __mods["Responsive"]
    AnimulaUI.Effects    = __mods["OceanEffects"]
    AnimulaUI.Motion     = __mods["Motion"]

    __mods["AnimulaUI"] = AnimulaUI
    return AnimulaUI
end
