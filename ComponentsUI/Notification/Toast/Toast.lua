--!strict
-- Notification/Toast/Toast.lua - toast notification (pojok kanan bawah)
-- ada queue limit 5 biar gak spam, anti-lag

local Theme       = require(script.Parent.Parent.Parent.Theme.AnimulaTheme)
local Utils       = require(script.Parent.Parent.Parent.Core.Utils)
local Performance = require(script.Parent.Parent.Parent.Core.Performance)

local Toast = {}

local gui: ScreenGui? = nil
local container: Frame? = nil

local function ensureGui(): (ScreenGui, Frame)
    if gui and gui.Parent and container then
        return gui :: ScreenGui, container :: Frame
    end

    local hui = Utils.getHui()

    local sg = Instance.new("ScreenGui")
    sg.Name           = "AnimulaUI_Notifications"
    sg.ResetOnSpawn   = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder   = 9999
    sg.Parent         = hui

    local c = Instance.new("Frame")
    c.Name                  = "Container"
    c.BackgroundTransparency = 1
    c.Size                  = UDim2.fromScale(1, 1)
    c.Parent                = sg

    local list = Instance.new("UIListLayout")
    list.FillDirection       = Enum.FillDirection.Vertical
    list.HorizontalAlignment = Enum.HorizontalAlignment.Right
    list.VerticalAlignment   = Enum.VerticalAlignment.Bottom
    list.Padding             = UDim.new(0, 8)
    list.SortOrder           = Enum.SortOrder.LayoutOrder
    list.Parent              = c
    Utils.Padding(c, 0, 0, 16, 16)

    gui = sg
    container = c
    return sg, c
end

function Toast.Notify(cfg: any): Frame
    cfg = cfg or {}
    local title: string = cfg.Title or cfg.Name or "Notification"
    local desc: string  = cfg.Desc  or cfg.Description or cfg.Content or ""
    local duration: number = cfg.Duration or cfg.Time or 3
    local ntype: string = cfg.Type or "Info"

    local _, cont = ensureGui()
    local T = Theme.Current
    local R = Theme.Radius
    local F = Theme.Font
    local S = Theme.TextSize

    local colorMap: { [string]: Color3 } = {
        Info = T.Info, Success = T.Success, Warning = T.Warning, Error = T.Error,
    }
    local accent: Color3 = (colorMap :: any)[ntype] or T.Primary

    local toast = Instance.new("Frame")
    toast.BackgroundColor3 = T.Surface
    toast.Size             = UDim2.fromOffset(300, if desc ~= "" then 72 else 52)
    toast.Parent           = cont
    Utils.Corner(toast, R.Medium)
    Utils.Stroke(toast, T.Border, 1, 0.35)
    toast.ClipsDescendants = true

    local bar = Instance.new("Frame")
    bar.BackgroundColor3 = accent
    bar.Size             = UDim2.fromOffset(4, 999)
    bar.BorderSizePixel  = 0
    bar.Parent           = toast

    local t1 = Instance.new("TextLabel")
    t1.BackgroundTransparency = 1
    t1.Position   = UDim2.fromOffset(14, 10)
    t1.Size       = UDim2.new(1, -28, 0, 16)
    t1.FontFace   = F.Heading
    t1.TextSize   = S.Body
    t1.TextColor3 = T.Text
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.Text       = title
    t1.Parent     = toast

    if desc ~= "" then
        local t2 = Instance.new("TextLabel")
        t2.BackgroundTransparency = 1
        t2.Position   = UDim2.fromOffset(14, 28)
        t2.Size       = UDim2.new(1, -28, 0, 28)
        t2.FontFace   = F.Body
        t2.TextSize   = S.Small
        t2.TextColor3 = T.TextDim
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextYAlignment = Enum.TextYAlignment.Top
        t2.TextWrapped = true
        t2.Text        = desc
        t2.Parent      = toast
    end

    if cfg.Image and string.match(cfg.Image, "^rbxassetid://") then
        local img = Instance.new("ImageLabel")
        img.BackgroundTransparency = 1
        img.Size     = UDim2.fromOffset(20, 20)
        img.Position = UDim2.fromOffset(276, 10)
        img.Image    = cfg.Image
        img.Parent   = toast
    end

    Performance.EnforceLimit(cont, Performance.NotifyLimit)
    toast.Position = UDim2.new(0, 320, 0, 0)
    Performance.Tween(toast, { Position = UDim2.fromOffset(0, 0) }, 0.32, Enum.EasingStyle.Back)

    task.delay(duration, function()
        if toast.Parent then
            Performance.Tween(toast, { Position = UDim2.new(0, 320, 0, 0) }, 0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            task.wait(0.24)
            toast:Destroy()
        end
    end)

    return toast
end

return Toast
