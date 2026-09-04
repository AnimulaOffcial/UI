--!strict
-- Window/Effects/Wave.lua - efek ombak di belakang window
-- dipisah biar Window.lua gak kepanjangan wkwk

local Performance = require(script.Parent.Parent.Parent.Core.Performance)

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
