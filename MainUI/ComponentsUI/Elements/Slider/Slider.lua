--!strict
-- Slider/Slider.lua - AddSlider buat animula ui
-- dipanggil dari TabManager: Tab:AddSlider(cfg)
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
        if flag then
            local stored = Config:Initialize(flag, def)
            if typeof(stored) == "number" then def = math.clamp(stored, min, max) end
        end
        def = Utils.Round(def, step)
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
            if flag then Config:SetFlag(flag, v, true) end
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
        Utils.Connect(f, game:GetService("UserInputService").InputEnded, function(input: InputObject)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        Utils.Connect(f, game:GetService("UserInputService").InputChanged, function(input: InputObject)
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

end

return Element
