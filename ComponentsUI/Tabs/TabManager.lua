--!strict
-- =============================================================================
--  TabManager.lua — Membuat tabs di dalam Window (Orion: Window:MakeTab)
--  Lokasi: Script/MainUI/ComponentsUI/Tabs/TabManager.lua
--
--  Dipakai internal oleh Window; jangan require langsung.
--  Menambahkan method Window:MakeTab / Window:Tab / Window:AddTab
--  dan meng-inject semua element factories ke Tab.
-- =============================================================================

local Theme       = require(script.Parent.Parent.Theme.AnimulaTheme)
local Utils       = require(script.Parent.Parent.Core.Utils)
local Performance = require(script.Parent.Parent.Core.Performance)

-- Forward: element factories di-inject setelah Tab dibuat
local function injectElements(Tab: any, page: Frame)

    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize
    local Config = require(script.Parent.Parent.Core.Config)

    -- ── Card helper ────────────────────────────────────────────────────────
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

    -- ── Label ──────────────────────────────────────────────────────────────
    function Tab:AddLabel(text: string)
        local f = card(36)
        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size             = UDim2.fromScale(1, 1)
        lbl.FontFace         = F.Body
        lbl.TextSize         = S.Body
        lbl.TextColor3       = T.Text
        lbl.TextXAlignment   = Enum.TextXAlignment.Left
        lbl.Text             = text
        lbl.Parent           = f
        local obj: any = { Value = text }
        function obj:Set(t: string)
            lbl.Text = t
            obj.Value = t
        end
        return obj
    end
    Tab.Label = Tab.AddLabel

    -- ── Paragraph ──────────────────────────────────────────────────────────
    function Tab:AddParagraph(title: string, content: string)
        -- Orion memanggil AddParagraph("Title","Content")
        -- Animula juga support AddParagraph({Title, Desc})
        local t: string
        local d: string
        if typeof(title) == "table" then
            local cfg: any = title
            t = cfg.Title or "Paragraph"
            d = cfg.Desc or cfg.Description or cfg.Content or ""
        else
            t = (title :: string) or "Paragraph"
            d = (content :: string) or ""
        end

        local f = card(64)
        f.AutomaticSize = Enum.AutomaticSize.Y

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, 0, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = t
        titleLbl.Parent        = f

        local descLbl = Instance.new("TextLabel")
        descLbl.BackgroundTransparency = 1
        descLbl.Position       = UDim2.fromOffset(0, 20)
        descLbl.Size           = UDim2.new(1, 0, 0, 14)
        descLbl.AutomaticSize  = Enum.AutomaticSize.Y
        descLbl.FontFace       = F.Body
        descLbl.TextSize       = S.Small
        descLbl.TextColor3     = T.TextDim
        descLbl.TextXAlignment = Enum.TextXAlignment.Left
        descLbl.TextWrapped    = true
        descLbl.Text           = d
        descLbl.Parent         = f

        task.defer(function()
            f.Size = UDim2.new(1, 0, 0, descLbl.TextBounds.Y + 34)
        end)

        local obj: any = {}
        function obj:Set(newTitle: string, newDesc: string?)
            titleLbl.Text = newTitle
            if newDesc then descLbl.Text = newDesc end
        end
        return obj
    end
    Tab.Paragraph = Tab.AddParagraph

    -- ── Section ────────────────────────────────────────────────────────────
    function Tab:AddSection(cfg: any)
        local name: string
        if typeof(cfg) == "string" then
            name = cfg
        elseif typeof(cfg) == "table" then
            name = (cfg :: any).Name or "Section"
        else
            name = "Section"
        end

        local f = Instance.new("Frame")
        f.BackgroundTransparency = 1
        f.Size   = UDim2.new(1, 0, 0, 22)
        f.Parent = page

        local lbl = Instance.new("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.Size             = UDim2.fromScale(1, 1)
        lbl.FontFace         = F.Title
        lbl.TextSize         = S.Small
        lbl.TextColor3       = T.Accent
        lbl.TextXAlignment   = Enum.TextXAlignment.Left
        lbl.Text             = string.upper(name)
        lbl.Parent           = f
        return f
    end
    Tab.Section = Tab.AddSection

    -- ── Divider ────────────────────────────────────────────────────────────
    function Tab:AddDivider(text: string?)
        if typeof(text) == "table" then
            text = (text :: any).Name or (text :: any).Title
        end
        local f = Instance.new("Frame")
        f.BackgroundTransparency = 1
        f.Size   = UDim2.new(1, 0, 0, 20)
        f.Parent = page

        if text and text ~= "" then
            local lbl = Instance.new("TextLabel")
            lbl.BackgroundTransparency = 1
            lbl.Size       = UDim2.fromScale(1, 1)
            lbl.FontFace   = F.Heading
            lbl.TextSize   = S.Small
            lbl.TextColor3 = T.TextMuted
            lbl.Text       = "—  " .. text .. "  —"
            lbl.Parent     = f
        else
            local line = Instance.new("Frame")
            line.BackgroundColor3       = T.Border
            line.BackgroundTransparency = 0.45
            line.Size                   = UDim2.new(1, 0, 0, 1)
            line.Position               = UDim2.fromScale(0, 0.5)
            line.BorderSizePixel        = 0
            line.Parent                 = f
        end
        return f
    end
    Tab.Divider = Tab.AddDivider

    -- ── Button ─────────────────────────────────────────────────────────────
    function Tab:AddButton(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or cfg.Text or "Button"
        local desc: string? = cfg.Desc or cfg.Description
        local flag: string? = cfg.Flag
        local cb: (() -> ())? = cfg.Callback

        local h = if desc then 54 else 42
        local f = card(h)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -110, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        if desc then
            local d = Instance.new("TextLabel")
            d.BackgroundTransparency = 1
            d.Position       = UDim2.fromOffset(0, 18)
            d.Size           = UDim2.new(1, -110, 0, 14)
            d.FontFace       = F.Body
            d.TextSize       = S.Small
            d.TextColor3     = T.TextDim
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.Text           = desc
            d.Parent         = f
        end

        local btn = Instance.new("TextButton")
        btn.BackgroundColor3 = T.Primary
        btn.Size             = UDim2.fromOffset(96, 30)
        btn.Position         = UDim2.new(1, -96, 0.5, -15)
        btn.FontFace         = F.Heading
        btn.TextSize         = S.Small
        btn.TextColor3       = T.TextOnPrimary
        btn.Text             = cfg.ButtonText or "Execute"
        btn.AutoButtonColor  = false
        btn.Parent           = f
        Utils.Corner(btn, R.Small)
        Utils.Gradient(btn, T.Primary, T.PrimaryDark, 90)

        btn.MouseEnter:Connect(function()
            Utils.Tween(btn, { BackgroundColor3 = T.PrimaryLight }, 0.12)
        end)
        btn.MouseLeave:Connect(function()
            Utils.Tween(btn, { BackgroundColor3 = T.Primary }, 0.12)
        end)

        local function fire()
            if cb then task.spawn(cb) end
            if flag then Config:SetFlag(flag, true) end
        end
        btn.MouseButton1Click:Connect(fire)

        local obj: any = { Value = false }
        function obj:SetText(t: string) btn.Text = t end
        obj.Fire = fire
        return obj
    end
    Tab.Button = Tab.AddButton

    -- ── Toggle ─────────────────────────────────────────────────────────────
    function Tab:AddToggle(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Toggle"
        local desc: string? = cfg.Desc or cfg.Description
        local def: boolean  = if cfg.Value ~= nil then cfg.Value
            elseif cfg.Default ~= nil then cfg.Default else false
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((boolean) -> ())? = cfg.Callback
        if flag then Config:SetFlag(flag, def) end

        local h = if desc then 54 else 42
        local f = card(h)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -64, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        if desc then
            local d = Instance.new("TextLabel")
            d.BackgroundTransparency = 1
            d.Position       = UDim2.fromOffset(0, 18)
            d.Size           = UDim2.new(1, -64, 0, 14)
            d.FontFace       = F.Body
            d.TextSize       = S.Small
            d.TextColor3     = T.TextDim
            d.TextXAlignment = Enum.TextXAlignment.Left
            d.Text           = desc
            d.Parent         = f
        end

        local track = Instance.new("Frame")
        track.BackgroundColor3 = if def then T.ToggleOn else T.ToggleOff
        track.Size             = UDim2.fromOffset(44, 24)
        track.Position         = UDim2.new(1, -44, 0.5, -12)
        track.Parent           = f
        Utils.Corner(track, UDim.new(1, 0))
        Utils.Stroke(track, T.Border, 1, 0.4)

        local knob = Instance.new("Frame")
        knob.BackgroundColor3 = Color3.new(1, 1, 1)
        knob.Size     = UDim2.fromOffset(18, 18)
        knob.Position = if def then UDim2.fromOffset(23, 3) else UDim2.fromOffset(3, 3)
        knob.Parent   = track
        Utils.Corner(knob, UDim.new(1, 0))

        local hit = Instance.new("TextButton")
        hit.BackgroundTransparency = 1
        hit.Size = UDim2.fromScale(1, 1)
        hit.Text = ""
        hit.Parent = f

        local state: boolean = def
        local obj: any = { Value = state, Save = save }

        local function set(v: boolean, noCb: boolean?)
            state     = v
            obj.Value = v
            Utils.Tween(track, { BackgroundColor3 = if v then T.ToggleOn else T.ToggleOff }, 0.18)
            Utils.Tween(knob,  { Position = if v then UDim2.fromOffset(23, 3) else UDim2.fromOffset(3, 3) }, 0.18)
            if flag then Config:SetFlag(flag, v) end
            if not noCb and cb then task.spawn(cb, v) end
        end

        hit.MouseButton1Click:Connect(function() set(not state) end)
        if flag then Config:Register(flag, obj) end

        function obj:Set(v: boolean) set(v) end
        function obj:Get() return state end

        set(def, true)
        return obj
    end
    Tab.Toggle = Tab.AddToggle

    -- ── Slider ─────────────────────────────────────────────────────────────
    function Tab:AddSlider(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Slider"
        local min: number   = cfg.Min or cfg.Minimum or 0
        local max: number   = cfg.Max or cfg.Maximum or 100
        local def: number   = cfg.Value or cfg.Default or min
        local step: number  = cfg.Increment or cfg.Step or 1
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((number) -> ())? = cfg.Callback
        local suffix: string = cfg.Suffix or cfg.ValueName or ""
        if suffix ~= "" then suffix = " " .. suffix end

        def = math.clamp(def, min, max)
        if flag then Config:SetFlag(flag, def) end

        local f = card(62)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -70, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local valueLbl = Instance.new("TextLabel")
        valueLbl.BackgroundColor3 = T.SurfaceLight
        valueLbl.Size             = UDim2.fromOffset(62, 22)
        valueLbl.Position         = UDim2.new(1, -62, 0, 0)
        valueLbl.FontFace         = F.Heading
        valueLbl.TextSize         = S.Small
        valueLbl.TextColor3       = T.Accent
        valueLbl.Text             = tostring(def) .. suffix
        valueLbl.Parent           = f
        Utils.Corner(valueLbl, R.Small)
        Utils.Stroke(valueLbl, T.Border, 1, 0.5)

        local track = Instance.new("Frame")
        track.BackgroundColor3 = T.SliderTrack
        track.Size             = UDim2.new(1, 0, 0, 6)
        track.Position         = UDim2.fromOffset(0, 36)
        track.Parent           = f
        Utils.Corner(track, UDim.new(1, 0))

        local fill = Instance.new("Frame")
        fill.BackgroundColor3 = T.SliderFill
        fill.Size             = UDim2.new((def - min) / math.max(1, max - min), 0, 1, 0)
        fill.BorderSizePixel  = 0
        fill.Parent           = track
        Utils.Corner(fill, UDim.new(1, 0))
        Utils.Gradient(fill, T.Primary, T.Secondary, 0)

        local knob2 = Instance.new("Frame")
        knob2.BackgroundColor3 = Color3.new(1, 1, 1)
        knob2.Size     = UDim2.fromOffset(14, 14)
        knob2.Position = UDim2.new((def - min) / math.max(1, max - min), -7, 0.5, -7)
        knob2.Parent   = track
        Utils.Corner(knob2, UDim.new(1, 0))
        Utils.Stroke(knob2, T.Primary, 2, 0)

        local hit2 = Instance.new("TextButton")
        hit2.BackgroundTransparency = 1
        hit2.Size     = UDim2.new(1, 0, 0, 22)
        hit2.Position = UDim2.fromOffset(0, 28)
        hit2.Text     = ""
        hit2.Parent   = f

        local dragging = false
        local current: number = def
        local obj: any = { Value = def, Save = save }

        local function apply(v: number, noCb: boolean?)
            v = Utils.Round(Utils.Clamp(v, min, max), step)
            current   = v
            obj.Value = v
            local alpha = (v - min) / math.max(1, max - min)
            Utils.Tween(fill,  { Size = UDim2.new(alpha, 0, 1, 0) }, 0.08)
            Utils.Tween(knob2, { Position = UDim2.new(alpha, -7, 0.5, -7) }, 0.08)
            valueLbl.Text = tostring(v) .. suffix
            if flag then Config:SetFlag(flag, v) end
            if not noCb and cb then task.spawn(cb, v) end
        end

        local function fromInput(input: InputObject)
            local absPos  = track.AbsolutePosition.X
            local absSize = track.AbsoluteSize.X
            if absSize <= 0 then return end
            local rel = math.clamp((input.Position.X - absPos) / absSize, 0, 1)
            apply(min + rel * (max - min))
        end

        hit2.InputBegan:Connect(function(input: InputObject)
            local isMouse = input.UserInputType == Enum.UserInputType.MouseButton1
            local isTouch = input.UserInputType == Enum.UserInputType.Touch
            if isMouse or isTouch then
                dragging = true
                fromInput(input)
            end
        end)
        game:GetService("UserInputService").InputEnded:Connect(function(input: InputObject)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input: InputObject)
            local isMove = input.UserInputType == Enum.UserInputType.MouseMovement
            local isTouch = input.UserInputType == Enum.UserInputType.Touch
            if dragging and (isMove or isTouch) then fromInput(input) end
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(v: number) apply(v) end
        function obj:Get() return current end

        return obj
    end
    Tab.Slider = Tab.AddSlider

    -- ── Dropdown ───────────────────────────────────────────────────────────
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
        if flag then Config:SetFlag(flag, selected) end

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
            if flag then Config:SetFlag(flag, selected) end
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
        game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject)
            if open and input.UserInputType == Enum.UserInputType.MouseButton1 then
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

    -- ── Textbox / Input ────────────────────────────────────────────────────
    function Tab:AddTextbox(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Input"
        local placeholder: string = cfg.Placeholder or cfg.PlaceHolder or "Enter text..."
        local def: string   = cfg.Default or cfg.Value or ""
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((string) -> ())? = cfg.Callback
        local disappear: boolean = cfg.TextDisappear or false
        local numeric: boolean   = cfg.Numeric or false

        if flag and def ~= "" then Config:SetFlag(flag, def) end

        local f = card(52)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, 0, 0, 18)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local box = Instance.new("TextBox")
        box.BackgroundColor3   = T.Background
        box.Size               = UDim2.new(1, 0, 0, 28)
        box.Position           = UDim2.fromOffset(0, 22)
        box.FontFace           = F.Body
        box.TextSize           = S.Small
        box.TextColor3         = T.Text
        box.PlaceholderColor3  = T.TextMuted
        box.PlaceholderText    = placeholder
        box.Text               = def
        box.ClearTextOnFocus   = disappear
        box.Parent             = f
        Utils.Corner(box, R.Small)
        Utils.Stroke(box, T.Border, 1, 0.4)
        Utils.Padding(box, 10, 0, 10, 0)

        local obj: any = { Value = def, Save = save }

        box.Focused:Connect(function()
            local st = box:FindFirstChildOfClass("UIStroke") :: UIStroke?
            if st then Utils.Tween(st, { Color = T.Primary }, 0.15) end
        end)
        box.FocusLost:Connect(function()
            local st = box:FindFirstChildOfClass("UIStroke") :: UIStroke?
            if st then Utils.Tween(st, { Color = T.Border }, 0.15) end
            local val: string = box.Text
            if numeric then
                local n = tonumber(val)
                if n == nil then box.Text = def; return end
                val      = tostring(n)
                box.Text = val
            end
            obj.Value = val
            if flag then Config:SetFlag(flag, val) end
            if cb then task.spawn(cb, val) end
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(v: string) box.Text = v; obj.Value = v end
        function obj:Get() return box.Text end

        return obj
    end
    Tab.Textbox      = Tab.AddTextbox
    Tab.Input        = Tab.AddTextbox
    Tab.AddInput     = Tab.AddTextbox

    -- ── Colorpicker ────────────────────────────────────────────────────────
    function Tab:AddColorpicker(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Colorpicker"
        local def: Color3   = cfg.Default or cfg.Value or T.Primary
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((Color3) -> ())? = cfg.Callback
        if flag then Config:SetFlag(flag, def) end

        local f = card(42)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -50, 1, 0)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local preview = Instance.new("Frame")
        preview.BackgroundColor3 = def
        preview.Size     = UDim2.fromOffset(32, 24)
        preview.Position = UDim2.new(1, -32, 0.5, -12)
        preview.Parent   = f
        Utils.Corner(preview, R.Small)
        Utils.Stroke(preview, T.Border, 1, 0.4)

        local hit = Instance.new("TextButton")
        hit.BackgroundTransparency = 1
        hit.Size = UDim2.fromScale(1, 1)
        hit.Text = ""
        hit.Parent = f

        local current: Color3 = def
        local obj: any = { Value = def, Save = save }

        local function set(c: Color3, noCb: boolean?)
            current       = c
            obj.Value     = c
            preview.BackgroundColor3 = c
            if flag then Config:SetFlag(flag, c) end
            if not noCb and cb then task.spawn(cb, c) end
        end

        -- Popup picker
        local pickerOpen = false
        local picker: Frame? = nil

        local function openPicker()
            if pickerOpen then return end
            pickerOpen = true

            local pf = Instance.new("Frame")
            pf.Name              = "ColorPickerPopup"
            pf.BackgroundColor3  = T.SurfaceLight
            pf.Size              = UDim2.fromOffset(220, 160)
            pf.Position          = UDim2.new(1, -230, 0, 42)
            pf.Parent            = f
            pf.ZIndex            = 10
            Utils.Corner(pf, R.Medium)
            Utils.Stroke(pf, T.Border, 1, 0.4)
            Utils.Padding(pf, 10, 10, 10, 10)
            picker = pf

            local hueBar = Instance.new("Frame")
            hueBar.BackgroundColor3 = Color3.new(1, 1, 1)
            hueBar.Size   = UDim2.new(1, 0, 0, 18)
            hueBar.Parent = pf
            Utils.Corner(hueBar, R.Small)
            local hg = Instance.new("UIGradient")
            hg.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,    Color3.fromHSV(0,    1, 1)),
                ColorSequenceKeypoint.new(0.17, Color3.fromHSV(0.17, 1, 1)),
                ColorSequenceKeypoint.new(0.33, Color3.fromHSV(0.33, 1, 1)),
                ColorSequenceKeypoint.new(0.50, Color3.fromHSV(0.50, 1, 1)),
                ColorSequenceKeypoint.new(0.67, Color3.fromHSV(0.67, 1, 1)),
                ColorSequenceKeypoint.new(0.83, Color3.fromHSV(0.83, 1, 1)),
                ColorSequenceKeypoint.new(1,    Color3.fromHSV(1,    1, 1)),
            })
            hg.Parent = hueBar

            local satVal = Instance.new("Frame")
            satVal.BackgroundColor3 = current
            satVal.Size     = UDim2.new(1, 0, 0, 90)
            satVal.Position = UDim2.fromOffset(0, 26)
            satVal.Parent   = pf
            Utils.Corner(satVal, R.Small)

            local closeBtn = Instance.new("TextButton")
            closeBtn.BackgroundColor3 = T.Primary
            closeBtn.Size     = UDim2.new(1, 0, 0, 28)
            closeBtn.Position = UDim2.fromOffset(0, 122)
            closeBtn.FontFace = F.Heading
            closeBtn.TextSize = S.Small
            closeBtn.TextColor3 = T.TextOnPrimary
            closeBtn.Text     = "Close"
            closeBtn.Parent   = pf
            Utils.Corner(closeBtn, R.Small)

            local function pickFromMouse(input: InputObject, frame: Frame, isHue: boolean)
                local absPos  = frame.AbsolutePosition.X
                local absSize = frame.AbsoluteSize.X
                if absSize <= 0 then return end
                local rel = math.clamp((input.Position.X - absPos) / absSize, 0, 1)
                local h, s, v = current:ToHSV()
                if isHue then h = rel else s = rel end
                local c = Color3.fromHSV(h, s, v)
                set(c)
                satVal.BackgroundColor3 = c
            end

            local draggingHue = false
            hueBar.InputBegan:Connect(function(i: InputObject)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingHue = true
                    pickFromMouse(i, hueBar, true)
                end
            end)
            satVal.InputBegan:Connect(function(i: InputObject)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    pickFromMouse(i, satVal, false)
                end
            end)
            game:GetService("UserInputService").InputChanged:Connect(function(i: InputObject)
                if draggingHue and i.UserInputType == Enum.UserInputType.MouseMovement then
                    pickFromMouse(i, hueBar, true)
                end
            end)
            game:GetService("UserInputService").InputEnded:Connect(function(i: InputObject)
                if i.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingHue = false
                end
            end)
            closeBtn.MouseButton1Click:Connect(function()
                pickerOpen = false
                if picker then picker:Destroy(); picker = nil end
            end)
        end

        hit.MouseButton1Click:Connect(function()
            if pickerOpen then
                pickerOpen = false
                if picker then picker:Destroy(); picker = nil end
            else
                openPicker()
            end
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(c: Color3) set(c) end
        function obj:Get() return current end

        return obj
    end
    Tab.Colorpicker = Tab.AddColorpicker
    Tab.AddColorPicker = Tab.AddColorpicker

    -- ── Bind / Keybind ─────────────────────────────────────────────────────
    function Tab:AddBind(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Bind"
        local def: Enum.KeyCode = cfg.Default or cfg.Value or Enum.KeyCode.F
        -- Orion's Default bisa string; handle
        if typeof(def) == "string" then
            local ok, kc = pcall(function()
                return Enum.KeyCode[def :: string]
            end)
            if ok and kc then def = kc end
        end
        local hold: boolean = cfg.Hold or false
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((Enum.KeyCode) -> ())? = cfg.Callback
        if flag then Config:SetFlag(flag, def) end

        local f = card(42)

        local titleLbl = Instance.new("TextLabel")
        titleLbl.BackgroundTransparency = 1
        titleLbl.Size          = UDim2.new(1, -90, 1, 0)
        titleLbl.FontFace      = F.Heading
        titleLbl.TextSize      = S.Body
        titleLbl.TextColor3    = T.Text
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Text          = title
        titleLbl.Parent        = f

        local keyBtn = Instance.new("TextButton")
        keyBtn.BackgroundColor3 = T.Background
        keyBtn.Size     = UDim2.fromOffset(80, 26)
        keyBtn.Position = UDim2.new(1, -80, 0.5, -13)
        keyBtn.FontFace = F.Body
        keyBtn.TextSize = S.Small
        keyBtn.TextColor3 = T.Text
        keyBtn.Text     = (def :: Enum.KeyCode).Name
        keyBtn.AutoButtonColor = false
        keyBtn.Parent   = f
        Utils.Corner(keyBtn, R.Small)
        Utils.Stroke(keyBtn, T.Border, 1, 0.4)

        local current: Enum.KeyCode = def :: Enum.KeyCode
        local listening = false
        local obj: any = { Value = current, Save = save }

        local function set(k: Enum.KeyCode)
            current   = k
            obj.Value = k
            keyBtn.Text = k.Name
            if flag then Config:SetFlag(flag, k) end
            if cb then task.spawn(cb, k) end
        end

        -- Hold mode
        if hold and cb then
            game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.KeyCode == current then task.spawn(cb, true) end
            end)
            game:GetService("UserInputService").InputEnded:Connect(function(input: InputObject)
                if input.KeyCode == current then task.spawn(cb, false) end
            end)
        elseif cb then
            game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.KeyCode == current then task.spawn(cb, current) end
            end)
        end

        keyBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            keyBtn.Text      = "..."
            keyBtn.TextColor3 = T.Primary
            local conn: RBXScriptConnection
            conn = game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, gp: boolean)
                if gp then return end
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    conn:Disconnect()
                    listening = false
                    keyBtn.TextColor3 = T.Text
                    set(input.KeyCode)
                end
            end)
            task.delay(5, function()
                if listening then
                    listening = false
                    if conn.Connected then conn:Disconnect() end
                    keyBtn.Text      = current.Name
                    keyBtn.TextColor3 = T.Text
                end
            end)
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(k: Enum.KeyCode) set(k) end
        function obj:Get() return current end

        return obj
    end
    Tab.Bind        = Tab.AddBind
    Tab.Keybind     = Tab.AddBind
    Tab.AddKeybind  = Tab.AddBind
end

-- =============================================================================
--  Attach tabs ke Window
-- =============================================================================
local TabManager = {}

function TabManager.Attach(window: any)
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local sidebar       = window._sidebar       :: ScrollingFrame
    local contentScroll = window._content       :: ScrollingFrame

    -- -----------------------------------------------------------------------
    --  Window:MakeTab
    -- -----------------------------------------------------------------------
    local function makeTab(tabConfig: any): any
        tabConfig = tabConfig or {}
        local tabTitle: string = tabConfig.Name or tabConfig.Title
            or ("Tab " .. tostring(#window._tabs + 1))
        local tabIcon: string? = tabConfig.Icon
        local isDefault: boolean = tabConfig.Default == true
            or #window._tabs == 0

        -- Sidebar button
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
        tabIconLbl.Text = if tabIcon
            then (if #tabIcon <= 4 then tabIcon else "◇")
            else "◇"
        tabIconLbl.Parent = tabBtn

        -- Support rbxassetid:// icon via ImageLabel overlay
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

        -- Page
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
        Tab._btn   = tabBtn
        Tab._page  = page
        Tab.Name   = tabTitle
        Tab.Title  = tabTitle

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
                    if ch:IsA("TextLabel") then
                        (ch :: TextLabel).TextColor3 = T.TextDim
                    end
                end
            end
            page.Visible      = true
            window._activeTab = Tab
            setActive(true)
            task.defer(function()
                contentScroll.CanvasPosition = Vector2.zero
            end)
        end

        tabBtn.MouseButton1Click:Connect(function() Tab:Select() end)
        tabBtn.MouseEnter:Connect(function()
            if window._activeTab ~= Tab then
                Utils.Tween(tabBtn, { BackgroundColor3 = T.SurfaceHover }, 0.12)
            end
        end)
        tabBtn.MouseLeave:Connect(function()
            if window._activeTab ~= Tab then
                Utils.Tween(tabBtn, { BackgroundColor3 = T.SurfaceLight }, 0.12)
            end
        end)

        -- Inject all element factories
        injectElements(Tab, page)

        table.insert(window._tabs, Tab)
        if isDefault then Tab:Select() end

        return Tab
    end

    -- Orion-style aliases
    window.MakeTab = makeTab
    window.Tab     = makeTab
    window.AddTab  = makeTab
end

return TabManager
