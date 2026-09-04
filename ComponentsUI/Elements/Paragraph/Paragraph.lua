--!strict
-- Paragraph/Paragraph.lua - AddParagraph buat animula ui
-- dipanggil dari TabManager: Tab:AddParagraph(cfg)
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
end

return Element
