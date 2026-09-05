--!strict
-- ColorPicker/ColorPicker.lua - AddColorpicker buat animula ui
-- dipanggil dari TabManager: Tab:AddColorpicker(cfg)
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

    function Tab:AddColorpicker(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Colorpicker"
        local def: Color3   = cfg.Default or cfg.Value or T.Primary
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((Color3) -> ())? = cfg.Callback
        if flag then
            local stored = Config:Initialize(flag, def)
            if typeof(stored) == "Color3" then def = stored end
        end

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
            if flag then Config:SetFlag(flag, c, true) end
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
            hueBar.Active = true
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
            satVal.Active   = true
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
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    draggingHue = true
                    pickFromMouse(i, hueBar, true)
                end
            end)
            satVal.InputBegan:Connect(function(i: InputObject)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    pickFromMouse(i, satVal, false)
                end
            end)
            Utils.Connect(pf, game:GetService("UserInputService").InputChanged, function(i: InputObject)
                if draggingHue and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                    pickFromMouse(i, hueBar, true)
                end
            end)
            Utils.Connect(pf, game:GetService("UserInputService").InputEnded, function(i: InputObject)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
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

end

return Element
