--!strict
-- Notification/Popup/Popup.lua - floating popup kecil

local Theme       = require(script.Parent.Parent.Parent.Theme.AnimulaTheme)
local Utils       = require(script.Parent.Parent.Parent.Core.Utils)
local Performance = require(script.Parent.Parent.Parent.Core.Performance)

local Popup = {}

function Popup.Show(cfg: any): any
    cfg = cfg or {}
    local title: string = cfg.Title or cfg.Name or "Popup"
    local desc: string  = cfg.Desc  or cfg.Description or cfg.Content or ""
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize
    local hui = Utils.getHui()

    local sg = Instance.new("ScreenGui")
    sg.Name           = "AnimulaUI_Popup"
    sg.ResetOnSpawn   = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder   = 90
    sg.Parent         = hui

    local popup = Instance.new("Frame")
    popup.BackgroundColor3 = T.Surface
    popup.Size     = UDim2.fromOffset(320, 140)
    popup.Position = UDim2.fromScale(0.5, 0.5)
    popup.AnchorPoint = Vector2.new(0.5, 0.5)
    popup.Parent   = sg
    Utils.Corner(popup, R.Large)
    Utils.Stroke(popup, T.Border, 1, 0.3)

    local t1 = Instance.new("TextLabel")
    t1.BackgroundTransparency = 1
    t1.Position   = UDim2.fromOffset(16, 12)
    t1.Size       = UDim2.new(1, -32, 0, 18)
    t1.FontFace   = F.Title
    t1.TextSize   = 14
    t1.TextColor3 = T.Text
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Text       = title
    t1.Parent     = popup

    if desc ~= "" then
        local d = Instance.new("TextLabel")
        d.BackgroundTransparency = 1
        d.Position   = UDim2.fromOffset(16, 34)
        d.Size       = UDim2.new(1, -32, 0, 60)
        d.FontFace   = F.Body
        d.TextSize   = S.Small
        d.TextColor3 = T.TextDim
        d.TextWrapped = true
        d.TextXAlignment = Enum.TextXAlignment.Left
        d.TextYAlignment = Enum.TextYAlignment.Top
        d.Text        = desc
        d.Parent      = popup
    end

    local closeBtn = Instance.new("TextButton")
    closeBtn.BackgroundColor3 = T.SurfaceLight
    closeBtn.Size     = UDim2.fromOffset(24, 24)
    closeBtn.Position = UDim2.new(1, -32, 0, 8)
    closeBtn.FontFace = F.Body
    closeBtn.TextSize = 12
    closeBtn.TextColor3 = T.TextMuted
    closeBtn.Text     = "x"
    closeBtn.Parent   = popup
    Utils.Corner(closeBtn, UDim.new(1, 0))

    local function close()
        Performance.Tween(popup, { BackgroundTransparency = 1 }, 0.16)
        task.wait(0.16)
        sg:Destroy()
    end
    closeBtn.MouseButton1Click:Connect(close)
    task.delay(cfg.Duration or 4, close)
    return { Close = close }
end

return Popup
