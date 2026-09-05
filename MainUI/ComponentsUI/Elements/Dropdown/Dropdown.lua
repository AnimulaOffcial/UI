--!strict
-- Dropdown/Dropdown.lua - AddDropdown buat animula ui
-- dipanggil dari TabManager: Tab:AddDropdown(cfg)
-- gw pisah biar ComponentsUI keliatan rapih, gak numpuk di satu file wkwk

local Element = {}

function Element.Apply(Tab: any, page: Frame, Theme: any, Utils: any, Config: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local function card(height: number, bg: Color3?): Frame
        local f = Instance.new("Frame")
        f.BackgroundColor3 = bg or T.Surface
        f.Size             = UDim2.new(1, 0, 0, height)
        f.Parent           = page
        Utils.Corner(f, R.Medium)
        Utils.Stroke(f, T.Border, 1, 0.38)
        Utils.Padding(f, 12, 10, 12, 10)
        return f
    end

    function Tab:AddDropdown(cfg: any)
        cfg = cfg or {}
        local title: string   = cfg.Name or cfg.Title or "Dropdown"
        local options: {string} = cfg.Options or cfg.Values or cfg.List or { "Option 1" }
        local def: string?    = cfg.Default or cfg.Value
        local multi: boolean  = cfg.Multi or cfg.Multiple or false
        local flag: string?   = cfg.Flag
        local save: boolean   = cfg.Save or false
        local cb: ((any) -> ())? = cfg.Callback

        local selected: any = if multi then {} else (def or options[1])
        if multi and typeof(def) == "table" then selected = def end
        if flag then
            local stored = Config:Initialize(flag, selected)
            if multi and typeof(stored) == "table" then
                selected = stored
            elseif not multi and typeof(stored) == "string" then
                selected = stored
            end
        end

        local f = card(52)
        f.ClipsDescendants = false
        f.ZIndex           = 2

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, 0, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local box = Instance.new("TextButton")
        box.BackgroundColor3 = T.SurfaceLight
        box.Size             = UDim2.new(1, 0, 0, 28)
        box.Position         = UDim2.fromOffset(0, 22)
        box.FontFace         = F.Body
        box.TextSize         = S.Small
        box.TextColor3       = T.Text
        box.Text             = ""
        box.AutoButtonColor  = false
        box.ClipsDescendants = false
        box.Parent           = f
        Utils.Corner(box, R.Small)
        Utils.Stroke(box, T.Border, 1, 0.4)
        Utils.Padding(box, 10, 0, 30, 0)

        local boxText = Instance.new("TextLabel")
        boxText.BackgroundTransparency = 1
        boxText.Size          = UDim2.fromScale(1, 1)
        boxText.FontFace      = F.Body
        boxText.TextSize      = S.Small
        boxText.TextColor3    = T.Text
        boxText.TextXAlignment = Enum.TextXAlignment.Left
        boxText.TextTruncate  = Enum.TextTruncate.AtEnd
        boxText.Parent        = box

        local arrow = Instance.new("TextLabel")
        arrow.BackgroundTransparency = 1
        arrow.Size       = UDim2.fromOffset(20, 20)
        arrow.Position   = UDim2.new(1, -24, 0.5, -10)
        arrow.FontFace   = F.Body
        arrow.TextSize   = 12
        arrow.TextColor3 = T.TextMuted
        arrow.Text       = "▾"
        arrow.Parent     = box

        local function displayText(): string
            if multi then
                if typeof(selected) == "table" and #selected > 0 then
                    return table.concat(selected, ", ")
                else
                    return "Select..."
                end
            else
                return tostring(selected)
            end
        end
        boxText.Text = displayText()

        -- List frame
        local listFrame = Instance.new("Frame")
        listFrame.Name              = "List"
        listFrame.BackgroundColor3  = T.SurfaceLight
        listFrame.Size              = UDim2.new(1, 0, 0, 0)
        listFrame.Position          = UDim2.new(0, 0, 1, 6)
        listFrame.Visible           = false
        listFrame.ClipsDescendants  = true
        listFrame.Parent            = box
        Utils.Corner(listFrame, R.Small)
        Utils.Stroke(listFrame, T.Border, 1, 0.35)

        local listScroll = Instance.new("ScrollingFrame")
        listScroll.BackgroundTransparency = 1
        listScroll.Size               = UDim2.fromScale(1, 1)
        listScroll.CanvasSize         = UDim2.fromOffset(0, 0)
        listScroll.ScrollBarThickness = 2
        listScroll.BorderSizePixel    = 0
        listScroll.Parent             = listFrame
        Utils.Padding(listScroll, 4, 4, 4, 4)

        local listLayout = Instance.new("UIListLayout")
        listLayout.FillDirection = Enum.FillDirection.Vertical
        listLayout.Padding       = UDim.new(0, 2)
        listLayout.Parent        = listScroll

        local open = false
        local function setOpen(v: boolean)
            open              = v
            listFrame.Visible = v
            arrow.Text        = if v then "▴" else "▾"
            if v then
                local h = math.clamp(#options * 30 + 8, 30, 150)
                Utils.Tween(listFrame, { Size = UDim2.new(1, 0, 0, h) }, 0.18)
                listScroll.CanvasSize = UDim2.fromOffset(0, #options * 32)
            else
                Utils.Tween(listFrame, { Size = UDim2.new(1, 0, 0, 0) }, 0.14)
            end
        end

        local obj: any = { Value = selected, Save = save }

        local function refreshText()
            boxText.Text = displayText()
            obj.Value    = selected
            if flag then Config:SetFlag(flag, selected, true) end
            if cb then task.spawn(cb, selected) end
        end

        local function buildItems()
            for _, ch in ipairs(listScroll:GetChildren()) do
                if ch:IsA("TextButton") then ch:Destroy() end
            end
            for _, opt in ipairs(options) do
                local item = Instance.new("TextButton")
                item.BackgroundColor3 = T.Surface
                item.Size             = UDim2.new(1, 0, 0, 28)
                item.FontFace         = F.Body
                item.TextSize         = S.Small
                item.TextColor3       = T.TextDim
                item.Text             = "  " .. opt
                item.TextXAlignment   = Enum.TextXAlignment.Left
                item.AutoButtonColor  = false
                item.Parent           = listScroll
                Utils.Corner(item, R.Small)

                local function isSelected(): boolean
                    if multi then
                        if typeof(selected) ~= "table" then return false end
                        return table.find(selected, opt) ~= nil
                    else
                        return selected == opt
                    end
                end

                local function updateLook()
                    if isSelected() then
                        item.BackgroundColor3 = T.Primary
                        item.TextColor3       = T.TextOnPrimary
                    else
                        item.BackgroundColor3 = T.Surface
                        item.TextColor3       = T.TextDim
                    end
                end
                updateLook()

                item.MouseEnter:Connect(function()
                    if not isSelected() then
                        Utils.Tween(item, { BackgroundColor3 = T.SurfaceHover }, 0.1)
                    end
                end)
                item.MouseLeave:Connect(updateLook)

                item.MouseButton1Click:Connect(function()
                    if multi then
                        if typeof(selected) ~= "table" then selected = {} end
                        local idx = table.find(selected, opt)
                        if idx then table.remove(selected, idx)
                        else table.insert(selected, opt) end
                    else
                        selected = opt
                        setOpen(false)
                    end
                    for _, ch in ipairs(listScroll:GetChildren()) do
                        if ch:IsA("TextButton") then
                            local txt: string = (ch :: TextButton).Text:gsub("^%s+", "")
                            local sel: boolean = if multi
                                then (typeof(selected) == "table" and table.find(selected, txt) ~= nil)
                                else (selected == txt)
                            if sel then
                                ch.BackgroundColor3            = T.Primary
                                ;(ch :: TextButton).TextColor3 = T.TextOnPrimary
                            else
                                ch.BackgroundColor3            = T.Surface
                                ;(ch :: TextButton).TextColor3 = T.TextDim
                            end
                        end
                    end
                    refreshText()
                end)
            end
        end
        buildItems()

        box.MouseButton1Click:Connect(function() setOpen(not open) end)
        Utils.Connect(f, game:GetService("UserInputService").InputBegan, function(input: InputObject)
            if open and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                local pos     = input.Position
                local absPos  = box.AbsolutePosition
                local absSize = box.AbsoluteSize
                local inBox   = pos.X >= absPos.X and pos.X <= absPos.X + absSize.X
                    and pos.Y >= absPos.Y and pos.Y <= absPos.Y + absSize.Y + listFrame.AbsoluteSize.Y + 6
                if not inBox then setOpen(false) end
            end
        end)

        if flag then Config:Register(flag, obj) end

        function obj:Set(v: any)
            selected = v
            refreshText()
        end
        function obj:Get() return selected end
        function obj:Refresh(newOpts: {string}, clear: boolean?)
            if clear then options = {} end
            options = newOpts
            buildItems()
            boxText.Text = displayText()
        end
        function obj:SetOptions(newOpts: {string}) self:Refresh(newOpts, true) end

        return obj
    end
    Tab.Dropdown = Tab.AddDropdown

end

return Element
