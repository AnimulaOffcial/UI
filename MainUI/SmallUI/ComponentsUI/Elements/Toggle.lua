--!strict

return function(parent: Instance, text: string, defaultValue: boolean?, callback: ((boolean) -> ())?)
    local state = defaultValue == true
    local toggle = Instance.new("TextButton")
    toggle.BackgroundColor3 = Color3.fromRGB(19, 35, 76)
    toggle.BorderSizePixel = 0
    toggle.Font = Enum.Font.GothamBold
    toggle.Size = UDim2.new(1, 0, 0, 52)
    toggle.Text = text
    toggle.TextColor3 = Color3.fromRGB(241, 247, 255)
    toggle.TextSize = 15
    toggle.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = toggle
    toggle.MouseButton1Click:Connect(function()
        state = not state
        if callback then callback(state) end
    end)
    return toggle
end
