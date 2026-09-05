--!strict
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
        Perf = require(script.Parent.Performance)
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
