--!strict
-- Standalone one-feature card. It creates exactly one Button or Toggle control.

local TweenService = game:GetService("TweenService")

local SmallUI = {}

local Theme = {
    Background = Color3.fromRGB(8, 15, 35),
    Surface = Color3.fromRGB(18, 34, 73),
    SurfaceHover = Color3.fromRGB(27, 51, 105),
    Primary = Color3.fromRGB(75, 145, 255),
    PrimaryLight = Color3.fromRGB(124, 207, 255),
    Border = Color3.fromRGB(68, 111, 190),
    Text = Color3.fromRGB(244, 248, 255),
    Muted = Color3.fromRGB(165, 188, 226),
}

local function rootGui(): Instance
    local ok, hiddenUi = pcall(function()
        return gethui()
    end)
    if ok and hiddenUi then return hiddenUi end
    return game:GetService("CoreGui")
end

local function tween(target: Instance, properties: { [string]: any }, duration: number)
    TweenService:Create(target, TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), properties):Play()
end

local function corner(target: Instance, radius: number)
    local value = Instance.new("UICorner")
    value.CornerRadius = UDim.new(0, radius)
    value.Parent = target
end

local function clearExisting()
    for _, item in ipairs(rootGui():GetChildren()) do
        if item:IsA("ScreenGui") and item.Name == "AnimulaSmallUI" then item:Destroy() end
    end
end

local function invoke(callback: ((boolean?) -> ())?, value: boolean?)
    if not callback then return end
    task.spawn(function()
        local ok, message = pcall(callback, value)
        if not ok then warn("[Animula SmallUI] callback failed: " .. tostring(message)) end
    end)
end

function SmallUI.Create(options: {
    Title: string?,
    Description: string?,
    Type: ("Button" | "Toggle")?,
    Text: string?,
    Default: boolean?,
    Callback: ((boolean?) -> ())?,
}?)
    options = options or {}
    local controlType = options.Type or "Button"
    if controlType ~= "Button" and controlType ~= "Toggle" then
        error("SmallUI Type must be Button or Toggle.")
    end
    clearExisting()

    local gui = Instance.new("ScreenGui")
    gui.Name = "AnimulaSmallUI"
    gui.DisplayOrder = 50
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = rootGui()

    local card = Instance.new("Frame")
    card.Name = "SingleFeature"
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.BackgroundColor3 = Theme.Background
    card.BorderSizePixel = 0
    card.Position = UDim2.fromScale(0.5, 0.5)
    card.Size = UDim2.fromOffset(372, 178)
    card.Parent = gui
    corner(card, 16)
    local outline = Instance.new("UIStroke")
    outline.Color = Theme.Border
    outline.Transparency = 0.18
    outline.Thickness = 1
    outline.Parent = card
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(Color3.fromRGB(13, 25, 58), Theme.Background)
    gradient.Rotation = 90
    gradient.Parent = card

    local scale = Instance.new("UIScale")
    scale.Scale = 0.94
    scale.Parent = card
    tween(scale, { Scale = 1 }, 0.22)

    local accent = Instance.new("Frame")
    accent.BackgroundColor3 = Theme.Primary
    accent.BorderSizePixel = 0
    accent.Position = UDim2.fromOffset(19, 19)
    accent.Size = UDim2.fromOffset(4, 39)
    accent.Parent = card
    corner(accent, 2)

    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Position = UDim2.fromOffset(35, 17)
    title.Size = UDim2.new(1, -54, 0, 24)
    title.Text = options.Title or "Animula"
    title.TextColor3 = Theme.Text
    title.TextSize = 18
    title.TextTruncate = Enum.TextTruncate.AtEnd
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = card

    local description = Instance.new("TextLabel")
    description.BackgroundTransparency = 1
    description.Font = Enum.Font.Gotham
    description.Position = UDim2.fromOffset(35, 43)
    description.Size = UDim2.new(1, -54, 0, 18)
    description.Text = options.Description or "One focused action."
    description.TextColor3 = Theme.Muted
    description.TextSize = 13
    description.TextTruncate = Enum.TextTruncate.AtEnd
    description.TextXAlignment = Enum.TextXAlignment.Left
    description.Parent = card

    local divider = Instance.new("Frame")
    divider.BackgroundColor3 = Theme.Border
    divider.BackgroundTransparency = 0.58
    divider.BorderSizePixel = 0
    divider.Position = UDim2.fromOffset(19, 77)
    divider.Size = UDim2.new(1, -38, 0, 1)
    divider.Parent = card

    local control = Instance.new("TextButton")
    control.Name = controlType
    control.AutoButtonColor = false
    control.BackgroundColor3 = Theme.Surface
    control.BorderSizePixel = 0
    control.Font = Enum.Font.GothamBold
    control.Position = UDim2.fromOffset(19, 94)
    control.Size = UDim2.new(1, -38, 0, 58)
    control.Text = options.Text or controlType
    control.TextColor3 = Theme.Text
    control.TextSize = 15
    control.TextTruncate = Enum.TextTruncate.AtEnd
    control.TextXAlignment = Enum.TextXAlignment.Left
    control.Parent = card
    corner(control, 11)
    local controlStroke = Instance.new("UIStroke")
    controlStroke.Color = Theme.Border
    controlStroke.Transparency = 0.48
    controlStroke.Parent = control

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 16)
    padding.PaddingRight = UDim.new(0, 16)
    padding.Parent = control

    control.MouseEnter:Connect(function()
        tween(control, { BackgroundColor3 = Theme.SurfaceHover }, 0.12)
        tween(controlStroke, { Color = Theme.PrimaryLight, Transparency = 0.18 }, 0.12)
    end)
    control.MouseLeave:Connect(function()
        tween(control, { BackgroundColor3 = Theme.Surface }, 0.12)
        tween(controlStroke, { Color = Theme.Border, Transparency = 0.48 }, 0.12)
    end)

    if controlType == "Button" then
        local arrow = Instance.new("TextLabel")
        arrow.BackgroundTransparency = 1
        arrow.Font = Enum.Font.Gotham
        arrow.AnchorPoint = Vector2.new(1, 0.5)
        arrow.Position = UDim2.new(1, -15, 0.5, 0)
        arrow.Size = UDim2.fromOffset(20, 28)
        arrow.Text = "›"
        arrow.TextColor3 = Theme.PrimaryLight
        arrow.TextSize = 25
        arrow.Parent = control
        control.MouseButton1Click:Connect(function()
            invoke(options.Callback, nil)
        end)
    else
        local state = options.Default == true
        local switch = Instance.new("Frame")
        switch.BackgroundColor3 = if state then Theme.Primary else Color3.fromRGB(12, 23, 50)
        switch.BorderSizePixel = 0
        switch.AnchorPoint = Vector2.new(1, 0.5)
        switch.Position = UDim2.new(1, -15, 0.5, 0)
        switch.Size = UDim2.fromOffset(44, 24)
        switch.Parent = control
        corner(switch, 12)
        local switchStroke = Instance.new("UIStroke")
        switchStroke.Color = Theme.Border
        switchStroke.Transparency = 0.36
        switchStroke.Parent = switch

        local thumb = Instance.new("Frame")
        thumb.BackgroundColor3 = Color3.new(1, 1, 1)
        thumb.BorderSizePixel = 0
        thumb.Position = if state then UDim2.fromOffset(24, 4) else UDim2.fromOffset(4, 4)
        thumb.Size = UDim2.fromOffset(16, 16)
        thumb.Parent = switch
        corner(thumb, 8)

        control.Text = options.Text or "Toggle"
        control.MouseButton1Click:Connect(function()
            state = not state
            tween(switch, { BackgroundColor3 = if state then Theme.Primary else Color3.fromRGB(12, 23, 50) }, 0.14)
            tween(thumb, { Position = if state then UDim2.fromOffset(24, 4) else UDim2.fromOffset(4, 4) }, 0.14)
            invoke(options.Callback, state)
        end)
    end

    return {
        Destroy = function()
            if gui.Parent then gui:Destroy() end
        end,
    }
end

return SmallUI
