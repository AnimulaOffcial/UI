--!strict
-- Window/Sidebar/Sidebar.lua - sidebar kiri (daftar tabs)
-- simple tapi elegan, ada collapse buat HP

local Utils = require(script.Parent.Parent.Parent.Core.Utils)

local Sidebar = {}

export type SidebarResult = {
    frame: ScrollingFrame,
    list: UIListLayout,
}

function Sidebar.Build(body: Frame, T: any, R: any): SidebarResult
    local frame = Instance.new("ScrollingFrame")
    frame.Name                    = "Sidebar"
    frame.BackgroundColor3        = T.Background
    frame.BackgroundTransparency  = 0.22
    frame.Size                    = UDim2.new(0, 168, 1, -12)
    frame.Position                = UDim2.fromOffset(8, 6)
    frame.CanvasSize              = UDim2.fromOffset(0, 0)
    frame.ScrollBarThickness      = 2
    frame.ScrollBarImageColor3    = T.Primary
    frame.ScrollingDirection      = Enum.ScrollingDirection.Y
    frame.BorderSizePixel         = 0
    frame.ZIndex                  = 5
    frame.Parent                  = body
    Utils.Corner(frame, R.Large)
    Utils.Stroke(frame, T.Border, 1, 0.45)
    Utils.Padding(frame, 6, 8, 6, 8)

    local list = Instance.new("UIListLayout")
    list.FillDirection = Enum.FillDirection.Vertical
    list.Padding       = UDim.new(0, 4)
    list.SortOrder     = Enum.SortOrder.LayoutOrder
    list.Parent        = frame

    return { frame = frame, list = list }
end

return Sidebar
