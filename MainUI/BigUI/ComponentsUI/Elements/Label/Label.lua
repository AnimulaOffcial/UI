--!strict
-- Label/Label.lua - AddLabel buat animula ui
-- dipanggil dari TabManager: Tab:AddLabel(cfg)
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
end

return Element
