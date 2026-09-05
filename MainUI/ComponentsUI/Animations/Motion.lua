--!strict
-- motion.lua - animasi buat animula ui
-- gw bikin biar ui nya gak kaku, ada spring, slide, fade, scale
-- inspirasinya dari framer motion tapi versi roblox wkwk

local Performance = require(script.Parent.Parent.Core.Performance)

local Motion = {}

-- spring - kayak pegas, enak buat popup / tab switch
function Motion.Spring(obj: Instance, props: { [string]: any }, damping: number?, speed: number?)
    -- di roblox gak ada spring beneran, jadi kita fake pake Back easing
    local s: number = speed or 0.35
    return Performance.Tween(obj, props, s, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

-- slide in dari samping
function Motion.SlideIn(frame: GuiObject, from: string?, time: number?)
    local t: number = time or 0.3
    local origPos: UDim2 = frame.Position
    local dir: string = from or "left"

    local offset: UDim2
    if dir == "left" then
        offset = UDim2.new(origPos.X.Scale, origPos.X.Offset - 40, origPos.Y.Scale, origPos.Y.Offset)
    elseif dir == "right" then
        offset = UDim2.new(origPos.X.Scale, origPos.X.Offset + 40, origPos.Y.Scale, origPos.Y.Offset)
    elseif dir == "top" then
        offset = UDim2.new(origPos.X.Scale, origPos.X.Offset, origPos.Y.Scale, origPos.Y.Offset - 30)
    else
        offset = UDim2.new(origPos.X.Scale, origPos.X.Offset, origPos.Y.Scale, origPos.Y.Offset + 30)
    end

    frame.Position               = offset
    frame.BackgroundTransparency = 0.3
    Performance.Tween(frame, { Position = origPos, BackgroundTransparency = 0 }, t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    -- fade text juga
    for _, ch: Instance in ipairs(frame:GetDescendants()) do
        if ch:IsA("TextLabel") or ch:IsA("TextButton") then
            local lbl: TextLabel = ch :: any
            local ot: number = lbl.TextTransparency
            lbl.TextTransparency = 1
            Performance.Tween(lbl, { TextTransparency = ot }, t + 0.08)
        end
    end
end

-- fade in
function Motion.FadeIn(obj: GuiObject, time: number?)
    local t: number = time or 0.22
    obj.BackgroundTransparency = 1
    Performance.Tween(obj, { BackgroundTransparency = 0 }, t)
    for _, ch: Instance in ipairs(obj:GetDescendants()) do
        if ch:IsA("TextLabel") or ch:IsA("TextButton") or ch:IsA("TextBox") then
            local lbl: any = ch
            local ot: number = lbl.TextTransparency
            lbl.TextTransparency = 1
            Performance.Tween(lbl, { TextTransparency = ot }, t)
        end
        if ch:IsA("ImageLabel") then
            local img: ImageLabel = ch :: any
            local oi: number = img.ImageTransparency
            img.ImageTransparency = 1
            Performance.Tween(img, { ImageTransparency = oi }, t)
        end
    end
end

-- scale pop - dari kecil ke gede, buat dialog / popup
function Motion.Pop(frame: GuiObject, time: number?)
    local t: number = time or 0.32
    local origSize: UDim2 = frame.Size
    frame.Size = UDim2.new(origSize.X.Scale, origSize.X.Offset - 20, origSize.Y.Scale, origSize.Y.Offset - 20)
    frame.BackgroundTransparency = 0.4
    Performance.Tween(frame, { Size = origSize, BackgroundTransparency = 0 }, t, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

-- tab switch - slide + fade, biar pindah tab gak boring
function Motion.TabSwitch(oldPage: Frame?, newPage: Frame)
    if oldPage and oldPage.Parent then
        -- old geser kiri + fade
        Performance.Tween(oldPage, { Position = UDim2.new(0, -18, 0, 0) }, 0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.delay(0.14, function()
            if oldPage.Parent then oldPage.Visible = false end
            oldPage.Position = UDim2.fromOffset(0, 0)
        end)
    end

    newPage.Visible  = true
    newPage.Position = UDim2.new(0, 18, 0, 0)
    -- cari background transparency awal
    local ot: number = 0
    pcall(function() ot = (newPage :: any).BackgroundTransparency end)
    Performance.Tween(newPage, { Position = UDim2.fromOffset(0, 0) }, 0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    -- stagger child nya
    local kids: { GuiObject } = {}
    for _, ch: Instance in ipairs(newPage:GetChildren()) do
        if ch:IsA("GuiObject") then table.insert(kids, ch :: GuiObject) end
    end
    Performance.Stagger(kids, 0.03, 0.2)
end

-- button press - mengecil dikit pas di klik
function Motion.Press(btn: GuiObject)
    btn.InputBegan:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Performance.Tween(btn, { Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset - 2, btn.Size.Y.Scale, btn.Size.Y.Offset - 1) }, 0.08)
        end
    end)
    btn.InputEnded:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Performance.Tween(btn, { Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset + 2, btn.Size.Y.Scale, btn.Size.Y.Offset + 1) }, 0.14, Enum.EasingStyle.Back)
        end
    end)
end

-- shake - buat error / warning
function Motion.Shake(frame: GuiObject)
    local orig: UDim2 = frame.Position
    for i = 1, 4 do
        local off: number = if i % 2 == 0 then 6 else -6
        Performance.Tween(frame, { Position = UDim2.new(orig.X.Scale, orig.X.Offset + off, orig.Y.Scale, orig.Y.Offset) }, 0.06).Completed:Wait()
    end
    Performance.Tween(frame, { Position = orig }, 0.08)
end

-- pulse - kedip pelan, buat notif penting
function Motion.Pulse(frame: GuiObject, color: Color3?, times: number?)
    local n: number = times or 2
    local orig: Color3 = frame.BackgroundColor3
    local c: Color3 = color or Color3.fromRGB(77, 163, 255)
    for _ = 1, n do
        Performance.Tween(frame, { BackgroundColor3 = c }, 0.2).Completed:Wait()
        if not frame.Parent then break end
        Performance.Tween(frame, { BackgroundColor3 = orig }, 0.2).Completed:Wait()
        if not frame.Parent then break end
    end
end

-- typewriter - text muncul satu2 kayak ngetik
function Motion.Typewriter(label: TextLabel, fullText: string, speed: number?)
    local s: number = speed or 0.02
    label.Text = ""
    for i = 1, #fullText do
        if not label.Parent then break end
        label.Text = string.sub(fullText, 1, i)
        task.wait(s)
    end
end

-- count up - angka jalan dari 0 ke target, cakep buat stat
function Motion.CountUp(label: TextLabel, from: number, to: number, duration: number?, suffix: string?)
    local d: number = duration or 0.8
    local suf: string = suffix or ""
    local steps: number = 20
    local stepTime: number = d / steps
    for i = 1, steps do
        if not label.Parent then break end
        local v: number = math.floor(from + (to - from) * (i / steps))
        label.Text = tostring(v) .. suf
        task.wait(stepTime)
    end
    if label.Parent then label.Text = tostring(to) .. suf end
end

return Motion
