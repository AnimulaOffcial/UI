--!strict
-- Window/Content/Content.lua - content wrap + scrolling
-- glass effect + highlight + responsive collapse support

local Utils   = require(script.Parent.Parent.Parent.Core.Utils)
local Bubbles = require(script.Parent.Parent.Effects.Bubbles)

local Content = {}

export type ContentResult = {
    wrap: Frame,
    scroll: ScrollingFrame,
    list: UIListLayout,
}

function Content.Build(
    body: Frame,
    T: any,
    R: any,
    isPhone: boolean
): ContentResult
    local sidebarW: number = if isPhone then 0 else 168
    local contentX: number = if isPhone then 8 else 176
    local contentW: number = if isPhone then -16 else -184

    local wrap = Instance.new("Frame")
    wrap.Name                     = "ContentWrap"
    wrap.BackgroundColor3         = T.SurfaceLight
    wrap.BackgroundTransparency   = 0.08
    wrap.Size                     = UDim2.new(1, contentW, 1, -12)
    wrap.Position                 = UDim2.new(0, contentX, 0, 6)
    wrap.ZIndex                   = 5
    wrap.ClipsDescendants         = true
    wrap.Parent                   = body
    Utils.Corner(wrap, R.Large)
    Utils.Stroke(wrap, T.Border, 1, 0.38)

    -- glass highlight atas
    do
        local hl = Instance.new("Frame")
        hl.Name                   = "Highlight"
        hl.BackgroundColor3       = Color3.new(1, 1, 1)
        hl.BackgroundTransparency = 0.94
        hl.Size                   = UDim2.new(1, -2, 0, 1)
        hl.Position               = UDim2.fromOffset(1, 1)
        hl.BorderSizePixel        = 0
        hl.ZIndex                 = 6
        hl.Parent                 = wrap
    end

    -- bubbles biar hidup, ringan kok
    Bubbles.Spawn(wrap)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Name                         = "Content"
    scroll.BackgroundTransparency       = 1
    scroll.Size                         = UDim2.fromScale(1, 1)
    scroll.CanvasSize                   = UDim2.fromOffset(0, 0)
    scroll.ScrollBarThickness           = 3
    scroll.ScrollBarImageColor3         = T.Primary
    scroll.ScrollBarImageTransparency   = 0.3
    scroll.BorderSizePixel              = 0
    scroll.ZIndex                       = 6
    scroll.Parent                       = wrap
    Utils.Padding(scroll, 14, 14, 14, 14)

    local list = Instance.new("UIListLayout")
    list.FillDirection = Enum.FillDirection.Vertical
    list.Padding       = UDim.new(0, 10)
    list.SortOrder     = Enum.SortOrder.LayoutOrder
    list.Parent        = scroll

    return { wrap = wrap, scroll = scroll, list = list }
end

return Content
