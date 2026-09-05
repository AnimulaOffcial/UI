--!strict
-- TabManager.lua - attach tabs ke window (modular)
-- sekarang elements di split per-file di Elements/Button, Toggle, dll
-- jadi ComponentsUI keliatan rapih, gak numpuk 1000 baris di satu file wkwk

local Theme = require(script.Parent.Parent.Theme.AnimulaTheme)
local Utils = require(script.Parent.Parent.Core.Utils)

-- inject elements dari file terpisah
local function injectElements(Tab: any, page: Frame)
    -- helper card dipass ke tiap element via Apply
    -- tiap element punya file sendiri: Elements/Button/Button.lua dll
    local base = script.Parent.Parent.Elements

    local function tryApply(folder: string, file: string)
        local ok, mod = pcall(function()
            local folderInst = base:FindFirstChild(folder)
            if not folderInst then return nil end
            local fileInst = folderInst:FindFirstChild(file)
            if not fileInst then return nil end
            return require(fileInst)
        end)
        if ok and mod and mod.Apply then
            local ok2, err = pcall(function()
                mod.Apply(Tab, page, Theme, Utils, require(script.Parent.Parent.Core.Config))
            end)
            if not ok2 then
                warn("[AnimulaUI] gagal load element " .. folder .. "/" .. file .. ": " .. tostring(err))
            end
        elseif not ok then
            warn("[AnimulaUI] require gagal " .. folder .. "/" .. file)
        end
    end

    tryApply("Label", "Label")
    tryApply("Paragraph", "Paragraph")
    tryApply("Section", "Section")
    tryApply("Divider", "Divider")
    tryApply("Button", "Button")
    tryApply("Toggle", "Toggle")
    tryApply("Slider", "Slider")
    tryApply("Dropdown", "Dropdown")
    tryApply("Textbox", "Textbox")
    tryApply("ColorPicker", "ColorPicker")
    tryApply("Keybind", "Keybind")
end

local TabManager = {}

function TabManager.Attach(window: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local sidebar       = window._sidebar       :: ScrollingFrame
    local contentScroll = window._content       :: ScrollingFrame

    local function makeTab(tabConfig: any): any
        tabConfig = tabConfig or {}
        local tabTitle: string = tabConfig.Name or tabConfig.Title or ("Tab " .. tostring(#window._tabs + 1))
        local tabIcon: string? = tabConfig.Icon
        local isDefault: boolean = tabConfig.Default == true or #window._tabs == 0

        local tabBtn = Instance.new("TextButton")
        tabBtn.Name                  = tabTitle
        tabBtn.BackgroundColor3      = T.SurfaceLight
        tabBtn.BackgroundTransparency = 0.4
        tabBtn.Size                  = UDim2.new(1, 0, 0, 36)
        tabBtn.AutoButtonColor       = false
        tabBtn.Text                  = ""
        tabBtn.Parent                = sidebar
        Utils.Corner(tabBtn, R.Medium)
        Utils.Stroke(tabBtn, T.Border, 1, 0.55)

        local tabIconLbl = Instance.new("TextLabel")
        tabIconLbl.BackgroundTransparency = 1
        tabIconLbl.Size       = UDim2.fromOffset(28, 28)
        tabIconLbl.Position   = UDim2.fromOffset(6, 4)
        tabIconLbl.FontFace   = F.Body
        tabIconLbl.TextSize   = 14
        tabIconLbl.TextColor3 = T.TextDim
        tabIconLbl.Text = if tabIcon then (if #tabIcon <= 4 then tabIcon else "◇") else "◇"
        tabIconLbl.Parent = tabBtn

        if tabIcon and string.match(tabIcon, "^rbxassetid://") then
            local img = Instance.new("ImageLabel")
            img.BackgroundTransparency = 1
            img.Size     = UDim2.fromOffset(20, 20)
            img.Position = UDim2.fromOffset(8, 8)
            img.Image    = tabIcon
            img.Parent   = tabBtn
            tabIconLbl.Visible = false
        end

        local tabText = Instance.new("TextLabel")
        tabText.BackgroundTransparency = 1
        tabText.Position   = UDim2.fromOffset(34, 0)
        tabText.Size       = UDim2.new(1, -40, 1, 0)
        tabText.FontFace   = F.Heading
        tabText.TextSize   = S.Body
        tabText.TextColor3 = T.TextDim
        tabText.TextXAlignment = Enum.TextXAlignment.Left
        tabText.Text       = tabTitle
        tabText.Parent     = tabBtn

        local page = Instance.new("Frame")
        page.Name            = "Page_" .. tabTitle
        page.BackgroundTransparency = 1
        page.Size            = UDim2.new(1, 0, 0, 0)
        page.AutomaticSize   = Enum.AutomaticSize.Y
        page.Visible         = false
        page.Parent          = contentScroll

        local pageList = Instance.new("UIListLayout")
        pageList.FillDirection = Enum.FillDirection.Vertical
        pageList.Padding       = UDim.new(0, 10)
        pageList.SortOrder     = Enum.SortOrder.LayoutOrder
        pageList.Parent        = page

        local Tab: any = {}
        Tab._btn  = tabBtn
        Tab._page = page
        Tab.Name  = tabTitle
        Tab.Title = tabTitle

        local function setActive(active: boolean)
            if active then
                Utils.Tween(tabBtn,     { BackgroundColor3 = T.Primary }, 0.18)
                Utils.Tween(tabText,    { TextColor3 = T.TextOnPrimary }, 0.18)
                Utils.Tween(tabIconLbl, { TextColor3 = T.TextOnPrimary }, 0.18)
                tabBtn.BackgroundTransparency = 0
                local st = tabBtn:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.PrimaryLight end
            else
                Utils.Tween(tabBtn,     { BackgroundColor3 = T.SurfaceLight }, 0.18)
                Utils.Tween(tabText,    { TextColor3 = T.TextDim }, 0.18)
                Utils.Tween(tabIconLbl, { TextColor3 = T.TextDim }, 0.18)
                tabBtn.BackgroundTransparency = 0.4
                local st = tabBtn:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.Border end
            end
        end

        function Tab:Select()
            for _, t in ipairs(window._tabs) do
                t._page.Visible = false
                local b = t._btn :: TextButton
                local st = b:FindFirstChildOfClass("UIStroke") :: UIStroke?
                if st then st.Color = T.Border end
                b.BackgroundColor3       = T.SurfaceLight
                b.BackgroundTransparency = 0.4
                for _, ch in ipairs(b:GetChildren()) do
                    if ch:IsA("TextLabel") then (ch :: TextLabel).TextColor3 = T.TextDim end
                end
            end
            page.Visible      = true
            window._activeTab = Tab
            setActive(true)
            task.defer(function() contentScroll.CanvasPosition = Vector2.zero end)
        end

        tabBtn.MouseButton1Click:Connect(function() Tab:Select() end)
        tabBtn.MouseEnter:Connect(function()
            if window._activeTab ~= Tab then Utils.Tween(tabBtn, { BackgroundColor3 = T.SurfaceHover }, 0.12) end
        end)
        tabBtn.MouseLeave:Connect(function()
            if window._activeTab ~= Tab then Utils.Tween(tabBtn, { BackgroundColor3 = T.SurfaceLight }, 0.12) end
        end)

        injectElements(Tab, page)

        table.insert(window._tabs, Tab)
        if isDefault then Tab:Select() end
        return Tab
    end

    window.MakeTab = makeTab
    window.Tab     = makeTab
    window.AddTab  = makeTab
end

return TabManager
