--!strict
-- Section/Section.lua - AddSection buat animula ui
-- dipanggil dari TabManager: Tab:AddSection(cfg)
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
end

return Element
