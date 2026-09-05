--!strict

local TweenService = game:GetService("TweenService")

return function(parent: Instance, caption: string, defaultValue: boolean?, callback: ((boolean) -> ())?)
    local state = defaultValue == true
    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.AutoButtonColor = false
    toggle.BackgroundColor3 = Color3.fromRGB(18, 34, 73)
    toggle.BorderSizePixel = 0
    toggle.Font = Enum.Font.GothamBold
    toggle.Size = UDim2.new(1, 0, 0, 48)
    toggle.Text = caption
    toggle.TextColor3 = Color3.fromRGB(244, 248, 255)
    toggle.TextSize = 15
    toggle.TextXAlignment = Enum.TextXAlignment.Left
    toggle.Parent = parent

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 15)
    padding.Parent = toggle
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 11)
    corner.Parent = toggle
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(68, 111, 190)
    border.Transparency = 0.55
    border.Parent = toggle

    local switch = Instance.new("Frame")
    switch.BackgroundColor3 = if state then Color3.fromRGB(75, 145, 255) else Color3.fromRGB(12, 23, 50)
    switch.BorderSizePixel = 0
    switch.AnchorPoint = Vector2.new(1, 0.5)
    switch.Position = UDim2.new(1, -15, 0.5, 0)
    switch.Size = UDim2.fromOffset(44, 24)
    switch.Parent = toggle
    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1, 0)
    switchCorner.Parent = switch

    local thumb = Instance.new("Frame")
    thumb.BackgroundColor3 = Color3.new(1, 1, 1)
    thumb.BorderSizePixel = 0
    thumb.Position = if state then UDim2.fromOffset(24, 4) else UDim2.fromOffset(4, 4)
    thumb.Size = UDim2.fromOffset(16, 16)
    thumb.Parent = switch
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(1, 0)
    thumbCorner.Parent = thumb

    toggle.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(switch, TweenInfo.new(0.14), { BackgroundColor3 = if state then Color3.fromRGB(75, 145, 255) else Color3.fromRGB(12, 23, 50) }):Play()
        TweenService:Create(thumb, TweenInfo.new(0.14), { Position = if state then UDim2.fromOffset(24, 4) else UDim2.fromOffset(4, 4) }):Play()
        if callback then task.spawn(callback, state) end
    end)
    return toggle
end
