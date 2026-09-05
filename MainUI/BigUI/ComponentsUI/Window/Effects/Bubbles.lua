--!strict
-- Window/Effects/Bubbles.lua - gelembung naik di content
-- lucu sih tapi jangan kebanyakan, 5 aja cukup biar gak lag

local Performance = require(script.Parent.Parent.Parent.Core.Performance)

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
