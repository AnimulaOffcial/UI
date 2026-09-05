--!strict
-- Toggle/Toggle.lua - AddToggle buat animula ui
-- dipanggil dari TabManager: Tab:AddToggle(cfg)
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

    function Tab:AddToggle(cfg: any)
        cfg = cfg or {}
        local title: string = cfg.Name or cfg.Title or "Toggle"
        local desc: string? = cfg.Desc or cfg.Description
        local def: boolean  = if cfg.Value ~= nil then cfg.Value
            elseif cfg.Default ~= nil then cfg.Default else false
        local flag: string? = cfg.Flag
        local save: boolean = cfg.Save or false
        local cb: ((boolean) -> ())? = cfg.Callback
        if flag then
            local stored = Config:Initialize(flag, def)
            if typeof(stored) == "boolean" then def = stored end
        end

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
            if flag then Config:SetFlag(flag, v, true) end
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

end

return Element
