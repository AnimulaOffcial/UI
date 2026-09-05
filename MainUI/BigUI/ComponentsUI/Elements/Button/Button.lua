--!strict
-- Button/Button.lua - AddButton buat animula ui
-- dipanggil dari TabManager: Tab:AddButton(cfg)
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
            if flag then Config:SetFlag(flag, true, true) end
        end
        btn.MouseButton1Click:Connect(fire)

        local obj: any = { Value = false }
        function obj:SetText(t: string) btn.Text = t end
        obj.Fire = fire
        return obj
    end
    Tab.Button = Tab.AddButton

end

return Element
