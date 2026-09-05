--!strict
-- Textbox/Textbox.lua - AddTextbox buat animula ui
-- dipanggil dari TabManager: Tab:AddTextbox(cfg)
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

        if flag then
            local stored = Config:Initialize(flag, def)
            if typeof(stored) == "string" then def = stored end
        end

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

        local function set(v: string, noCb: boolean?)
            box.Text = v
            obj.Value = v
            if flag then Config:SetFlag(flag, v, true) end
            if not noCb and cb then task.spawn(cb, v) end
        end

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
            set(val)
        end)

        if flag then Config:Register(flag, obj) end
        function obj:Set(v: string) set(v) end
        function obj:Get() return box.Text end

        return obj
    end
    Tab.Textbox      = Tab.AddTextbox
    Tab.Input        = Tab.AddTextbox
    Tab.AddInput     = Tab.AddTextbox

end

return Element
