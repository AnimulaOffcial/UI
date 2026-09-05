--!strict
-- Standalone one-feature UI. Each created card exposes exactly one Button or Toggle.

local SmallUI = {}

local Theme = {
    Background = Color3.fromRGB(10, 18, 43),
    Surface = Color3.fromRGB(19, 35, 76),
    Primary = Color3.fromRGB(68, 137, 255),
    Border = Color3.fromRGB(77, 129, 213),
    Text = Color3.fromRGB(241, 247, 255),
    Muted = Color3.fromRGB(165, 188, 224),
}

local function rootGui(): Instance
    local ok, hiddenUi = pcall(function()
        return gethui()
    end)
    if ok and hiddenUi then return hiddenUi end
    return game:GetService("CoreGui")
end

local function round(target: Instance, radius: number)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = target
end

local function clearExisting()
    for _, item in ipairs(rootGui():GetChildren()) do
        if item:IsA("ScreenGui") and item.Name == "AnimulaSmallUI" then
            item:Destroy()
        end
    end
end

function SmallUI.Create(options: {
    Title: string?,
    Description: string?,
    Type: "Button" | "Toggle"?,
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
    card.Size = UDim2.fromOffset(350, 164)
    card.Parent = gui
    round(card, 14)
    local border = Instance.new("UIStroke")
    border.Color = Theme.Border
    border.Transparency = 0.2
    border.Parent = card

    local title = Instance.new("TextLabel")
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Position = UDim2.fromOffset(18, 16)
    title.Size = UDim2.new(1, -36, 0, 24)
    title.Text = options.Title or "Animula"
    title.TextColor3 = Theme.Text
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = card

    local description = Instance.new("TextLabel")
    description.BackgroundTransparency = 1
    description.Font = Enum.Font.Gotham
    description.Position = UDim2.fromOffset(18, 43)
    description.Size = UDim2.new(1, -36, 0, 18)
    description.Text = options.Description or ""
    description.TextColor3 = Theme.Muted
    description.TextSize = 13
    description.TextTruncate = Enum.TextTruncate.AtEnd
    description.TextXAlignment = Enum.TextXAlignment.Left
    description.Parent = card

    local control = Instance.new("TextButton")
    control.BackgroundColor3 = Theme.Surface
    control.BorderSizePixel = 0
    control.Font = Enum.Font.GothamBold
    control.Position = UDim2.fromOffset(18, 86)
    control.Size = UDim2.new(1, -36, 0, 52)
    control.Text = options.Text or controlType
    control.TextColor3 = Theme.Text
    control.TextSize = 15
    control.AutoButtonColor = false
    control.Parent = card
    round(control, 10)

    if controlType == "Button" then
        control.MouseButton1Click:Connect(function()
            if options.Callback then options.Callback(nil) end
        end)
    else
        local state = options.Default == true
        local function update()
            control.BackgroundColor3 = if state then Theme.Primary else Theme.Surface
            control.Text = (options.Text or "Toggle") .. ": " .. (if state then "On" else "Off")
        end
        update()
        control.MouseButton1Click:Connect(function()
            state = not state
            update()
            if options.Callback then options.Callback(state) end
        end)
    end

    return {
        Destroy = function()
            gui:Destroy()
        end,
    }
end

return SmallUI
