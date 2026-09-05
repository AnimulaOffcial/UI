--!strict

return function(parent: Instance, caption: string, callback: (() -> ())?)
    local button = Instance.new("TextButton")
    button.Name = "Button"
    button.AutoButtonColor = false
    button.BackgroundColor3 = Color3.fromRGB(18, 34, 73)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.Size = UDim2.new(1, 0, 0, 58)
    button.Text = caption
    button.TextColor3 = Color3.fromRGB(244, 248, 255)
    button.TextSize = 15
    button.TextTruncate = Enum.TextTruncate.AtEnd
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = parent

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 16)
    padding.PaddingRight = UDim.new(0, 16)
    padding.Parent = button
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 11)
    corner.Parent = button
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(68, 111, 190)
    border.Transparency = 0.48
    border.Parent = button

    button.MouseButton1Click:Connect(function()
        if callback then task.spawn(callback) end
    end)
    return button
end
