--!strict

return function(parent: Instance, text: string, callback: (() -> ())?)
    local button = Instance.new("TextButton")
    button.BackgroundColor3 = Color3.fromRGB(19, 35, 76)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.Size = UDim2.new(1, 0, 0, 52)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(241, 247, 255)
    button.TextSize = 15
    button.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = button
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    return button
end
