--!strict

local TweenService = game:GetService("TweenService")

return function(parent: Instance, caption: string, callback: (() -> ())?)
    local button = Instance.new("TextButton")
    button.Name = "Button"
    button.AutoButtonColor = false
    button.BackgroundColor3 = Color3.fromRGB(18, 34, 73)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.Size = UDim2.new(1, 0, 0, 48)
    button.Text = caption
    button.TextColor3 = Color3.fromRGB(244, 248, 255)
    button.TextSize = 15
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = parent

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingRight = UDim.new(0, 15)
    padding.Parent = button
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 11)
    corner.Parent = button
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(68, 111, 190)
    border.Transparency = 0.55
    border.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(27, 51, 105) }):Play()
        TweenService:Create(border, TweenInfo.new(0.12), { Color = Color3.fromRGB(124, 207, 255), Transparency = 0.2 }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(18, 34, 73) }):Play()
        TweenService:Create(border, TweenInfo.new(0.12), { Color = Color3.fromRGB(68, 111, 190), Transparency = 0.55 }):Play()
    end)
    button.MouseButton1Click:Connect(function()
        if callback then task.spawn(callback) end
    end)
    return button
end
