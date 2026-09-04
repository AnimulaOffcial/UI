--!strict
-- Window/Header/TitleBar.lua - header window (icon + title + subtitle + controls)
-- glow di icon + ring gold + shimmer accent bar, premium abis

local Utils       = require(script.Parent.Parent.Parent.Core.Utils)
local Performance = require(script.Parent.Parent.Parent.Core.Performance)

local TitleBar = {}

export type TitleBarResult = {
    bar: Frame,
    iconLabel: TextLabel,
    titleLabel: TextLabel,
    subLabel: TextLabel,
    controls: Frame,
}

function TitleBar.Build(
    main: Frame,
    T: any,
    R: any,
    F: any,
    S: any,
    title: string,
    subTitle: string,
    icon: string?
): TitleBarResult
    local bar = Instance.new("Frame")
    bar.Name                   = "TitleBar"
    bar.BackgroundTransparency = 1
    bar.Size                   = UDim2.new(1, 0, 0, 52)
    bar.Position               = UDim2.fromOffset(0, 3)
    bar.ZIndex                 = 6
    bar.Parent                 = main

    -- icon bulat + gradient
    local iconWrap = Instance.new("Frame")
    iconWrap.Name             = "IconWrap"
    iconWrap.BackgroundColor3 = T.Primary
    iconWrap.Size             = UDim2.fromOffset(36, 36)
    iconWrap.Position         = UDim2.fromOffset(14, 8)
    iconWrap.ZIndex           = 7
    iconWrap.Parent           = bar
    Utils.Corner(iconWrap, UDim.new(1, 0))
    Utils.Gradient(iconWrap, T.Primary, T.Secondary, 35)

    -- glow belakang icon
    do
        local glow = Instance.new("ImageLabel")
        glow.Name              = "IconGlow"
        glow.BackgroundTransparency = 1
        glow.Image             = "rbxassetid://5028857084"
        glow.ImageColor3       = T.Glow
        glow.ImageTransparency = 0.55
        glow.ScaleType         = Enum.ScaleType.Slice
        glow.SliceCenter       = Rect.new(24, 24, 276, 276)
        glow.Size              = UDim2.new(1, 18, 1, 18)
        glow.Position          = UDim2.fromOffset(-9, -9)
        glow.ZIndex            = 6
        glow.Parent            = iconWrap
        task.spawn(function()
            while glow.Parent do
                Performance.Tween(glow, { ImageTransparency = 0.75 }, 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
                if not glow.Parent then break end
                Performance.Tween(glow, { ImageTransparency = 0.45 }, 1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut).Completed:Wait()
            end
        end)
    end

    -- ring gold
    do
        local ring = Instance.new("UIStroke")
        ring.Color        = T.AccentGold
        ring.Thickness    = 1.5
        ring.Transparency = 0.3
        ring.Parent       = iconWrap
    end

    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name                   = "Icon"
    iconLabel.BackgroundTransparency = 1
    iconLabel.Size                   = UDim2.fromScale(1, 1)
    iconLabel.FontFace               = F.Title
    iconLabel.TextSize               = 18
    iconLabel.TextColor3             = T.TextOnPrimary
    iconLabel.Text                   = "◈"
    iconLabel.ZIndex                 = 8
    iconLabel.Parent                 = iconWrap
    if icon and #icon <= 4 then
        iconLabel.Text = icon
    end

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name                   = "Title"
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position               = UDim2.fromOffset(58, 6)
    titleLabel.Size                   = UDim2.new(1, -140, 0, 20)
    titleLabel.FontFace               = F.Title
    titleLabel.TextSize               = S.Title
    titleLabel.TextColor3             = T.Text
    titleLabel.TextXAlignment         = Enum.TextXAlignment.Left
    titleLabel.TextTruncate           = Enum.TextTruncate.AtEnd
    titleLabel.Text                   = title
    titleLabel.ZIndex                 = 7
    titleLabel.Parent                 = bar

    local subLabel = Instance.new("TextLabel")
    subLabel.Name                   = "SubTitle"
    subLabel.BackgroundTransparency = 1
    subLabel.Position               = UDim2.fromOffset(58, 26)
    subLabel.Size                   = UDim2.new(1, -140, 0, 14)
    subLabel.FontFace               = F.Body
    subLabel.TextSize               = S.Small
    subLabel.TextColor3             = T.TextDim
    subLabel.TextXAlignment         = Enum.TextXAlignment.Left
    subLabel.Text                   = subTitle
    subLabel.ZIndex                 = 7
    subLabel.Parent                 = bar

    -- controls (min & close)
    local controls = Instance.new("Frame")
    controls.Name                   = "Controls"
    controls.BackgroundTransparency = 1
    controls.Size                   = UDim2.fromOffset(64, 32)
    controls.Position               = UDim2.new(1, -72, 0, 10)
    controls.ZIndex                 = 7
    controls.Parent                 = bar

    local layout = Instance.new("UIListLayout")
    layout.FillDirection       = Enum.FillDirection.Horizontal
    layout.Padding             = UDim.new(0, 6)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    layout.Parent              = controls

    return {
        bar = bar,
        iconLabel = iconLabel,
        titleLabel = titleLabel,
        subLabel = subLabel,
        controls = controls,
    }
end

return TitleBar
