--!strict
-- ocean effects - biar animula ui keliatan hidup
-- ada wave, shimmer, glow, glass, particle bubble
-- semua efek ringan ya, gak bikin lag

local Theme       = require(script.Parent.Parent.Theme.AnimulaTheme)
local Performance = require(script.Parent.Parent.Core.Performance)
local Utils       = require(script.Parent.Parent.Core.Utils)

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
