--!strict
-- Divider/Divider.lua - AddDivider buat animula ui
-- dipanggil dari TabManager: Tab:AddDivider(cfg)
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
end

return Element
