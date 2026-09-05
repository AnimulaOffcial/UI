--!strict
-- Standalone medium UI. Load directly; no ModuleScript hierarchy is required.

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local MediumUI = {}

local Theme = {
    Background = Color3.fromRGB(8, 15, 35),
    Surface = Color3.fromRGB(18, 34, 73),
    SurfaceHover = Color3.fromRGB(27, 51, 105),
    Primary = Color3.fromRGB(75, 145, 255),
    PrimaryLight = Color3.fromRGB(124, 207, 255),
    Border = Color3.fromRGB(68, 111, 190),
    Text = Color3.fromRGB(244, 248, 255),
    Muted = Color3.fromRGB(165, 188, 226),
    Dim = Color3.fromRGB(110, 141, 190),
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

local function stroke(target: Instance, color: Color3, transparency: number): UIStroke
    local value = Instance.new("UIStroke")
    value.Color = color
    value.Transparency = transparency
    value.Thickness = 1
    value.Parent = target
    return value
end

local function addGradient(target: Instance, top: Color3, bottom: Color3)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(top, bottom)
    gradient.Rotation = 90
    gradient.Parent = target
end

local function label(parent: Instance, content: string, textSize: number, bold: boolean): TextLabel
    local item = Instance.new("TextLabel")
    item.BackgroundTransparency = 1
    item.Font = if bold then Enum.Font.GothamBold else Enum.Font.Gotham
    item.Text = content
    item.TextColor3 = Theme.Text
    item.TextSize = textSize
    item.TextTruncate = Enum.TextTruncate.AtEnd
    item.TextXAlignment = Enum.TextXAlignment.Left
    item.Parent = parent
    return item
end

local function invoke(callback: (() -> ())?)
    if not callback then return end
    task.spawn(function()
        local ok, message = pcall(callback)
        if not ok then warn("[Animula MediumUI] callback failed: " .. tostring(message)) end
    end)
end

local function invokeToggle(callback: ((boolean) -> ())?, value: boolean)
    if not callback then return end
    task.spawn(function()
        local ok, message = pcall(callback, value)
        if not ok then warn("[Animula MediumUI] callback failed: " .. tostring(message)) end
    end)
end

local function clearExisting()
    for _, item in ipairs(rootGui():GetChildren()) do
        if item:IsA("ScreenGui") and item.Name == "AnimulaMediumUI" then
            item:Destroy()
        end
    end
end

local function enableDragging(handle: GuiObject, target: GuiObject)
    local dragging = false
    local dragStart = Vector2.zero
    local startPosition = target.Position

    handle.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        dragging = true
        dragStart = input.Position
        startPosition = target.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging or (input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch) then return end
        local offset = input.Position - dragStart
        target.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + offset.X, startPosition.Y.Scale, startPosition.Y.Offset + offset.Y)
    end)
end

function MediumUI.Create(options: { Title: string?, Subtitle: string? }?)
    clearExisting()
    options = options or {}

    local gui = Instance.new("ScreenGui")
    gui.Name = "AnimulaMediumUI"
    gui.DisplayOrder = 50
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = rootGui()

    local window = Instance.new("Frame")
    window.Name = "Window"
    window.AnchorPoint = Vector2.new(0.5, 0.5)
    window.BackgroundColor3 = Theme.Background
    window.BorderSizePixel = 0
    window.Position = UDim2.fromScale(0.5, 0.5)
    window.Size = UDim2.fromOffset(540, 350)
    window.Parent = gui
    corner(window, 16)
    stroke(window, Theme.Border, 0.2)
    addGradient(window, Color3.fromRGB(13, 25, 58), Theme.Background)

    local sizeLimit = Instance.new("UISizeConstraint")
    sizeLimit.MinSize = Vector2.new(360, 260)
    sizeLimit.MaxSize = Vector2.new(540, 350)
    sizeLimit.Parent = window

    local scale = Instance.new("UIScale")
    scale.Scale = 0.94
    scale.Parent = window
    tween(scale, { Scale = 1 }, 0.24)

    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Active = true
    header.BackgroundTransparency = 1
    header.Size = UDim2.new(1, 0, 0, 78)
    header.Parent = window
    enableDragging(header, window)

    local mark = Instance.new("Frame")
    mark.BackgroundColor3 = Theme.Primary
    mark.BorderSizePixel = 0
    mark.Position = UDim2.fromOffset(20, 19)
    mark.Size = UDim2.fromOffset(38, 38)
    mark.Parent = header
    corner(mark, 12)
    stroke(mark, Theme.PrimaryLight, 0.2)
    addGradient(mark, Theme.PrimaryLight, Theme.Primary)

    local markText = label(mark, "A", 17, true)
    markText.Size = UDim2.fromScale(1, 1)
    markText.TextColor3 = Color3.new(1, 1, 1)
    markText.TextXAlignment = Enum.TextXAlignment.Center

    local title = label(header, options.Title or "Animula", 21, true)
    title.Position = UDim2.fromOffset(72, 18)
    title.Size = UDim2.new(1, -144, 0, 25)

    local subtitle = label(header, options.Subtitle or "Medium interface", 13, false)
    subtitle.Position = UDim2.fromOffset(72, 43)
    subtitle.Size = UDim2.new(1, -144, 0, 18)
    subtitle.TextColor3 = Theme.Muted

    local close = Instance.new("TextButton")
    close.BackgroundColor3 = Theme.Surface
    close.BorderSizePixel = 0
    close.Position = UDim2.new(1, -52, 0, 24)
    close.Size = UDim2.fromOffset(28, 28)
    close.AutoButtonColor = false
    close.Font = Enum.Font.GothamBold
    close.Text = "×"
    close.TextColor3 = Theme.Muted
    close.TextSize = 20
    close.Parent = header
    corner(close, 9)
    local closeStroke = stroke(close, Theme.Border, 0.5)
    close.MouseEnter:Connect(function()
        tween(close, { BackgroundColor3 = Color3.fromRGB(92, 45, 65), TextColor3 = Theme.Text }, 0.12)
        tween(closeStroke, { Color = Color3.fromRGB(238, 103, 132), Transparency = 0.2 }, 0.12)
    end)
    close.MouseLeave:Connect(function()
        tween(close, { BackgroundColor3 = Theme.Surface, TextColor3 = Theme.Muted }, 0.12)
        tween(closeStroke, { Color = Theme.Border, Transparency = 0.5 }, 0.12)
    end)
    close.MouseButton1Click:Connect(function()
        tween(scale, { Scale = 0.94 }, 0.14)
        task.delay(0.14, function()
            if gui.Parent then gui:Destroy() end
        end)
    end)

    local divider = Instance.new("Frame")
    divider.BackgroundColor3 = Theme.Border
    divider.BackgroundTransparency = 0.55
    divider.BorderSizePixel = 0
    divider.Position = UDim2.fromOffset(20, 78)
    divider.Size = UDim2.new(1, -40, 0, 1)
    divider.Parent = window

    local controls = Instance.new("ScrollingFrame")
    controls.Name = "Controls"
    controls.Active = true
    controls.BackgroundTransparency = 1
    controls.BorderSizePixel = 0
    controls.CanvasSize = UDim2.fromOffset(0, 0)
    controls.Position = UDim2.fromOffset(20, 94)
    controls.ScrollBarImageColor3 = Theme.Primary
    controls.ScrollBarImageTransparency = 0.25
    controls.ScrollBarThickness = 3
    controls.Size = UDim2.new(1, -40, 1, -112)
    controls.Parent = window

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0, 9)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = controls
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        controls.CanvasSize = UDim2.fromOffset(0, list.AbsoluteContentSize.Y + 4)
    end)

    local api = {}

    function api:AddButton(config: { Text: string?, Description: string?, Callback: (() -> ())? }?)
        config = config or {}
        local hasDescription = type(config.Description) == "string" and config.Description ~= ""
        local card = Instance.new("TextButton")
        card.Name = "Button"
        card.AutoButtonColor = false
        card.BackgroundColor3 = Theme.Surface
        card.BorderSizePixel = 0
        card.Size = UDim2.new(1, 0, 0, if hasDescription then 64 else 48)
        card.Text = ""
        card.Parent = controls
        corner(card, 11)
        local cardStroke = stroke(card, Theme.Border, 0.55)

        local heading = label(card, config.Text or "Button", 15, true)
        heading.Position = UDim2.fromOffset(15, if hasDescription then 10 else 14)
        heading.Size = UDim2.new(1, -62, 0, 19)
        if hasDescription then
            local description = label(card, config.Description :: string, 12, false)
            description.Position = UDim2.fromOffset(15, 32)
            description.Size = UDim2.new(1, -62, 0, 17)
            description.TextColor3 = Theme.Muted
        end

        local arrow = label(card, "›", 24, false)
        arrow.AnchorPoint = Vector2.new(1, 0.5)
        arrow.Position = UDim2.new(1, -17, 0.5, 0)
        arrow.Size = UDim2.fromOffset(18, 24)
        arrow.TextColor3 = Theme.PrimaryLight
        arrow.TextXAlignment = Enum.TextXAlignment.Center

        card.MouseEnter:Connect(function()
            tween(card, { BackgroundColor3 = Theme.SurfaceHover }, 0.12)
            tween(cardStroke, { Color = Theme.PrimaryLight, Transparency = 0.22 }, 0.12)
        end)
        card.MouseLeave:Connect(function()
            tween(card, { BackgroundColor3 = Theme.Surface }, 0.12)
            tween(cardStroke, { Color = Theme.Border, Transparency = 0.55 }, 0.12)
        end)
        card.MouseButton1Click:Connect(function()
            invoke(config.Callback)
        end)
        return card
    end

    function api:AddToggle(config: { Text: string?, Description: string?, Default: boolean?, Callback: ((boolean) -> ())? }?)
        config = config or {}
        local state = config.Default == true
        local hasDescription = type(config.Description) == "string" and config.Description ~= ""
        local card = Instance.new("TextButton")
        card.Name = "Toggle"
        card.AutoButtonColor = false
        card.BackgroundColor3 = Theme.Surface
        card.BorderSizePixel = 0
        card.Size = UDim2.new(1, 0, 0, if hasDescription then 64 else 48)
        card.Text = ""
        card.Parent = controls
        corner(card, 11)
        local cardStroke = stroke(card, Theme.Border, 0.55)

        local heading = label(card, config.Text or "Toggle", 15, true)
        heading.Position = UDim2.fromOffset(15, if hasDescription then 10 else 14)
        heading.Size = UDim2.new(1, -94, 0, 19)
        if hasDescription then
            local description = label(card, config.Description :: string, 12, false)
            description.Position = UDim2.fromOffset(15, 32)
            description.Size = UDim2.new(1, -94, 0, 17)
            description.TextColor3 = Theme.Muted
        end

        local switch = Instance.new("Frame")
        switch.BackgroundColor3 = if state then Theme.Primary else Color3.fromRGB(12, 23, 50)
        switch.BorderSizePixel = 0
        switch.AnchorPoint = Vector2.new(1, 0.5)
        switch.Position = UDim2.new(1, -16, 0.5, 0)
        switch.Size = UDim2.fromOffset(44, 24)
        switch.Parent = card
        corner(switch, 12)
        stroke(switch, Theme.Border, 0.38)

        local thumb = Instance.new("Frame")
        thumb.BackgroundColor3 = Color3.new(1, 1, 1)
        thumb.BorderSizePixel = 0
        thumb.Position = if state then UDim2.fromOffset(24, 4) else UDim2.fromOffset(4, 4)
        thumb.Size = UDim2.fromOffset(16, 16)
        thumb.Parent = switch
        corner(thumb, 8)

        local function redraw()
            tween(switch, { BackgroundColor3 = if state then Theme.Primary else Color3.fromRGB(12, 23, 50) }, 0.14)
            tween(thumb, { Position = if state then UDim2.fromOffset(24, 4) else UDim2.fromOffset(4, 4) }, 0.14)
        end

        card.MouseEnter:Connect(function()
            tween(card, { BackgroundColor3 = Theme.SurfaceHover }, 0.12)
            tween(cardStroke, { Color = Theme.PrimaryLight, Transparency = 0.22 }, 0.12)
        end)
        card.MouseLeave:Connect(function()
            tween(card, { BackgroundColor3 = Theme.Surface }, 0.12)
            tween(cardStroke, { Color = Theme.Border, Transparency = 0.55 }, 0.12)
        end)
        card.MouseButton1Click:Connect(function()
            state = not state
            redraw()
            invokeToggle(config.Callback, state)
        end)
        return card
    end

    function api:Destroy()
        if gui.Parent then gui:Destroy() end
    end

    return api
end

return MediumUI
