--!strict
-- Standalone medium-size UI. It can be loaded directly and returns MediumUI.

local MediumUI = {}

local Theme = {
    Background = Color3.fromRGB(10, 18, 43),
    Surface = Color3.fromRGB(19, 35, 76),
    SurfaceHover = Color3.fromRGB(26, 48, 101),
    Primary = Color3.fromRGB(68, 137, 255),
    Border = Color3.fromRGB(77, 129, 213),
    Text = Color3.fromRGB(241, 247, 255),
    Muted = Color3.fromRGB(165, 188, 224),
    Success = Color3.fromRGB(74, 201, 157),
}

local function rootGui(): Instance
    local ok, hiddenUi = pcall(function()
        return gethui()
    end)
    if ok and hiddenUi then
        return hiddenUi
    end
    return game:GetService("CoreGui")
end

local function corner(target: Instance, radius: number)
    local value = Instance.new("UICorner")
    value.CornerRadius = UDim.new(0, radius)
    value.Parent = target
end

local function outline(target: Instance, color: Color3, transparency: number)
    local value = Instance.new("UIStroke")
    value.Color = color
    value.Transparency = transparency
    value.Thickness = 1
    value.Parent = target
    return value
end

local function text(parent: Instance, value: string, size: number, bold: boolean): TextLabel
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Font = if bold then Enum.Font.GothamBold else Enum.Font.Gotham
    label.Text = value
    label.TextColor3 = Theme.Text
    label.TextSize = size
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function clearExisting()
    for _, item in ipairs(rootGui():GetChildren()) do
        if item:IsA("ScreenGui") and item.Name == "AnimulaMediumUI" then
            item:Destroy()
        end
    end
end

function MediumUI.Create(options: { Title: string?, Subtitle: string? }?)
    clearExisting()
    options = options or {}

    local gui = Instance.new("ScreenGui")
    gui.Name = "AnimulaMediumUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = rootGui()

    local frame = Instance.new("Frame")
    frame.Name = "Window"
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Theme.Background
    frame.BorderSizePixel = 0
    frame.Position = UDim2.fromScale(0.5, 0.5)
    frame.Size = UDim2.fromOffset(520, 330)
    frame.Parent = gui
    corner(frame, 14)
    outline(frame, Theme.Border, 0.18)

    local header = Instance.new("Frame")
    header.BackgroundTransparency = 1
    header.Size = UDim2.new(1, 0, 0, 72)
    header.Parent = frame

    local title = text(header, options.Title or "Animula", 21, true)
    title.Position = UDim2.fromOffset(22, 16)
    title.Size = UDim2.new(1, -44, 0, 25)

    local subtitle = text(header, options.Subtitle or "Medium interface", 13, false)
    subtitle.Position = UDim2.fromOffset(22, 42)
    subtitle.Size = UDim2.new(1, -44, 0, 18)
    subtitle.TextColor3 = Theme.Muted

    local divider = Instance.new("Frame")
    divider.BackgroundColor3 = Theme.Border
    divider.BackgroundTransparency = 0.55
    divider.BorderSizePixel = 0
    divider.Position = UDim2.fromOffset(18, 72)
    divider.Size = UDim2.new(1, -36, 0, 1)
    divider.Parent = frame

    local list = Instance.new("ScrollingFrame")
    list.Name = "Controls"
    list.BackgroundTransparency = 1
    list.BorderSizePixel = 0
    list.CanvasSize = UDim2.fromOffset(0, 0)
    list.Position = UDim2.fromOffset(18, 88)
    list.ScrollBarImageColor3 = Theme.Primary
    list.ScrollBarThickness = 3
    list.Size = UDim2.new(1, -36, 1, -106)
    list.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = list
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        list.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 4)
    end)

    local window = {}

    function window:AddButton(config: { Text: string?, Description: string?, Callback: (() -> ())? })
        config = config or {}
        local button = Instance.new("TextButton")
        button.BackgroundColor3 = Theme.Surface
        button.BorderSizePixel = 0
        button.Font = Enum.Font.GothamBold
        button.Size = UDim2.new(1, 0, 0, if config.Description then 58 else 42)
        button.Text = ""
        button.AutoButtonColor = false
        button.Parent = list
        corner(button, 10)
        outline(button, Theme.Border, 0.55)

        local heading = text(button, config.Text or "Button", 15, true)
        heading.Position = UDim2.fromOffset(14, 8)
        heading.Size = UDim2.new(1, -28, 0, 20)

        if config.Description then
            local description = text(button, config.Description, 12, false)
            description.Position = UDim2.fromOffset(14, 29)
            description.Size = UDim2.new(1, -28, 0, 18)
            description.TextColor3 = Theme.Muted
        end

        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Theme.SurfaceHover
        end)
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Theme.Surface
        end)
        button.MouseButton1Click:Connect(function()
            if config.Callback then config.Callback() end
        end)
        return button
    end

    function window:AddToggle(config: { Text: string?, Description: string?, Default: boolean?, Callback: ((boolean) -> ())? })
        config = config or {}
        local state = config.Default == true
        local row = Instance.new("TextButton")
        row.BackgroundColor3 = Theme.Surface
        row.BorderSizePixel = 0
        row.Size = UDim2.new(1, 0, 0, if config.Description then 58 else 42)
        row.Text = ""
        row.AutoButtonColor = false
        row.Parent = list
        corner(row, 10)
        outline(row, Theme.Border, 0.55)

        local heading = text(row, config.Text or "Toggle", 15, true)
        heading.Position = UDim2.fromOffset(14, 8)
        heading.Size = UDim2.new(1, -78, 0, 20)
        if config.Description then
            local description = text(row, config.Description, 12, false)
            description.Position = UDim2.fromOffset(14, 29)
            description.Size = UDim2.new(1, -78, 0, 18)
            description.TextColor3 = Theme.Muted
        end

        local switch = Instance.new("Frame")
        switch.BackgroundColor3 = if state then Theme.Primary else Theme.Background
        switch.BorderSizePixel = 0
        switch.AnchorPoint = Vector2.new(1, 0.5)
        switch.Position = UDim2.new(1, -14, 0.5, 0)
        switch.Size = UDim2.fromOffset(42, 22)
        switch.Parent = row
        corner(switch, 11)
        outline(switch, Theme.Border, 0.35)

        local dot = Instance.new("Frame")
        dot.BackgroundColor3 = Color3.new(1, 1, 1)
        dot.BorderSizePixel = 0
        dot.Position = if state then UDim2.fromOffset(23, 3) else UDim2.fromOffset(3, 3)
        dot.Size = UDim2.fromOffset(16, 16)
        dot.Parent = switch
        corner(dot, 8)

        row.MouseButton1Click:Connect(function()
            state = not state
            switch.BackgroundColor3 = if state then Theme.Primary else Theme.Background
            dot.Position = if state then UDim2.fromOffset(23, 3) else UDim2.fromOffset(3, 3)
            if config.Callback then config.Callback(state) end
        end)
        return row
    end

    function window:Destroy()
        gui:Destroy()
    end

    return window
end

return MediumUI
