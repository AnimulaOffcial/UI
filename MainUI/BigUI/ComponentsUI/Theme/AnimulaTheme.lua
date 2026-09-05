--!strict
-- animula theme - biru hydro archon
-- gw bikin palet ini malem2 sambil dengerin ost fontaine wkwk
-- biru nya ambil dari gaun furina + vision hydro, mantep bgt

local Theme = {}

-- palet utama animula, jangan di ubah sembarangan ya
Theme.Animula = {
    Background    = Color3.fromRGB(8,   13,  31), -- midnight blue
    Surface       = Color3.fromRGB(15,  25,  54), -- main window
    SurfaceLight  = Color3.fromRGB(23,  39,  79), -- card / inactive tab
    SurfaceHover  = Color3.fromRGB(34,  59, 111), -- hover

    Primary       = Color3.fromRGB(74,  145, 255), -- royal hydro blue
    PrimaryDark   = Color3.fromRGB(49,   89, 202), -- gradient depth
    PrimaryLight  = Color3.fromRGB(135, 199, 255), -- glow
    Secondary     = Color3.fromRGB(106, 208, 255), -- aqua
    Accent        = Color3.fromRGB(180, 228, 255), -- ice blue
    AccentGold    = Color3.fromRGB(232, 207, 146), -- Furina gold trim

    Text          = Color3.fromRGB(241, 247, 255),
    TextDim       = Color3.fromRGB(174, 196, 229),
    TextMuted     = Color3.fromRGB(112, 139, 184),
    TextOnPrimary = Color3.fromRGB(255, 255, 255),

    Border        = Color3.fromRGB(47,  78,  143),
    BorderLight   = Color3.fromRGB(79, 119,  190),
    Shadow        = Color3.fromRGB(0,   0,   0),

    Success       = Color3.fromRGB(74,  222, 128),
    Warning       = Color3.fromRGB(251, 191, 36),
    Error         = Color3.fromRGB(248, 113, 113),
    Info          = Color3.fromRGB(96,  165, 250),

    ToggleOn      = Color3.fromRGB(77,  163, 255),
    ToggleOff     = Color3.fromRGB(38,  52,  80),
    SliderFill    = Color3.fromRGB(77,  163, 255),
    SliderTrack   = Color3.fromRGB(30,  45,  75),

    -- tambahan buat efek keren
    Glow          = Color3.fromRGB(90,  180, 255),
    Wave1         = Color3.fromRGB(77,  163, 255),
    Wave2         = Color3.fromRGB(120, 200, 255),
    GlassBg       = Color3.fromRGB(22,  36,  68),
}

-- varian theme, tadinya cuma dark doang, terus gw nambahin light sama midnight
-- midnight tuh paling gelap, enak buat mata malem2
Theme.Variants = {
    AnimulaDark = Theme.Animula,

    AnimulaLight = {
        Background    = Color3.fromRGB(232, 240, 255),
        Surface       = Color3.fromRGB(245, 248, 255),
        SurfaceLight  = Color3.fromRGB(255, 255, 255),
        SurfaceHover  = Color3.fromRGB(220, 232, 255),
        Primary       = Color3.fromRGB(42,  119, 217),
        PrimaryDark   = Color3.fromRGB(30,  88,  170),
        PrimaryLight  = Color3.fromRGB(77,  163, 255),
        Secondary     = Color3.fromRGB(56,  175, 230),
        Accent        = Color3.fromRGB(77,  163, 255),
        AccentGold    = Color3.fromRGB(168, 148, 90),
        Text          = Color3.fromRGB(18,  30,  55),
        TextDim       = Color3.fromRGB(70,  90,  125),
        TextMuted     = Color3.fromRGB(110, 130, 165),
        TextOnPrimary = Color3.fromRGB(255, 255, 255),
        Border        = Color3.fromRGB(190, 206, 235),
        BorderLight   = Color3.fromRGB(210, 222, 245),
        Shadow        = Color3.fromRGB(0,   0,   0),
        Success       = Color3.fromRGB(34,  158, 80),
        Warning       = Color3.fromRGB(200, 140, 0),
        Error         = Color3.fromRGB(210, 60,  60),
        Info          = Color3.fromRGB(42,  119, 217),
        ToggleOn      = Color3.fromRGB(42,  119, 217),
        ToggleOff     = Color3.fromRGB(200, 212, 232),
        SliderFill    = Color3.fromRGB(42,  119, 217),
        SliderTrack   = Color3.fromRGB(210, 222, 242),
        Glow          = Color3.fromRGB(60,  130, 255),
        Wave1         = Color3.fromRGB(42,  119, 217),
        Wave2         = Color3.fromRGB(90,  180, 255),
        GlassBg       = Color3.fromRGB(235, 242, 255),
    },

    AnimulaMidnight = {
        Background    = Color3.fromRGB(7,   11,  22),
        Surface       = Color3.fromRGB(12,  18,  36),
        SurfaceLight  = Color3.fromRGB(18,  28,  54),
        SurfaceHover  = Color3.fromRGB(24,  38,  70),
        Primary       = Color3.fromRGB(77,  163, 255),
        PrimaryDark   = Color3.fromRGB(42,  119, 217),
        PrimaryLight  = Color3.fromRGB(120, 188, 255),
        Secondary     = Color3.fromRGB(91,  202, 255),
        Accent        = Color3.fromRGB(155, 214, 255),
        AccentGold    = Color3.fromRGB(214, 196, 135),
        Text          = Color3.fromRGB(235, 245, 255),
        TextDim       = Color3.fromRGB(145, 165, 195),
        TextMuted     = Color3.fromRGB(95,  115, 148),
        TextOnPrimary = Color3.fromRGB(255, 255, 255),
        Border        = Color3.fromRGB(28,  44,  82),
        BorderLight   = Color3.fromRGB(40,  60,  108),
        Shadow        = Color3.fromRGB(0,   0,   0),
        Success       = Color3.fromRGB(74,  222, 128),
        Warning       = Color3.fromRGB(251, 191, 36),
        Error         = Color3.fromRGB(248, 113, 113),
        Info          = Color3.fromRGB(96,  165, 250),
        ToggleOn      = Color3.fromRGB(77,  163, 255),
        ToggleOff     = Color3.fromRGB(26,  36,  60),
        SliderFill    = Color3.fromRGB(77,  163, 255),
        SliderTrack   = Color3.fromRGB(20,  30,  55),
        Glow          = Color3.fromRGB(90,  180, 255),
        Wave1         = Color3.fromRGB(77,  163, 255),
        Wave2         = Color3.fromRGB(60,  120, 200),
        GlassBg       = Color3.fromRGB(14,  22,  42),
    },
}

-- buat backward compat aja, mungkin ada yg masih pake nama lama
Theme.Variants.AnimulaDark     = Theme.Variants.AnimulaDark
Theme.Variants.AnimulaLight    = Theme.Variants.AnimulaLight
Theme.Variants.AnimulaMidnight = Theme.Variants.AnimulaMidnight
Theme.Animula = Theme.Animula

Theme.Radius = {
    Small  = UDim.new(0,  6),
    Medium = UDim.new(0, 10),
    Large  = UDim.new(0, 14),
    Pill   = UDim.new(1,  0),
    Window = UDim.new(0, 16),
    Card   = UDim.new(0, 12),
}

Theme.Font = {
    Title   = Font.fromEnum(Enum.Font.GothamBold),
    Heading = Font.fromEnum(Enum.Font.GothamSemibold),
    Body    = Font.fromEnum(Enum.Font.Gotham),
    Mono    = Font.fromEnum(Enum.Font.Code),
}

Theme.TextSize = {
    Title   = 18,
    Heading = 14,
    Body    = 13,
    Small   = 11,
    Tiny    = 10,
}

-- ini yg aktif skrg
Theme.CurrentName = "AnimulaDark"
Theme.Current     = Theme.Animula

function Theme:SetVariant(name: string)
    local v = Theme.Variants[name]
    if v then
        Theme.CurrentName = name
        Theme.Current     = v
    else
        warn("[AnimulaTheme] gak nemu variant: " .. tostring(name))
    end
    return Theme.Current
end

function Theme:Get(key: string?): Color3
    if not key then return Theme.Current.Primary end
    return (Theme.Current :: any)[key] or Theme.Current.Primary
end

-- helper buat dapet warna dengan alpha (transparansi palsu)
function Theme:Alpha(key: string, alpha: number): Color3
    -- roblox gak ada alpha di Color3, jadi kita blend ke background
    local c = self:Get(key)
    local bg = self.Current.Background
    return Color3.new(
        c.R * alpha + bg.R * (1 - alpha),
        c.G * alpha + bg.G * (1 - alpha),
        c.B * alpha + bg.B * (1 - alpha)
    )
end

return Theme
