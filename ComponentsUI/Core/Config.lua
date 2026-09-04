--!strict
-- config / flags buat animula ui
-- konsep nya kayak orion: tiap element punya Flag, terus bisa di akses via Flags[flag].Value
-- gw tambahin save/load ke file juga biar gak ilang pas rejoin

local Config = {}

local _flags:     { [string]: any }         = {}
local _callbacks: { [string]: (any) -> () } = {}
local _elements:  { [string]: any }         = {} -- ref ke element object nya

function Config:SetFlag(flag: string, value: any)
    _flags[flag] = value
    local el = _elements[flag]
    if el then
        (el :: any).Value = value
    end
    local cb = _callbacks[flag]
    if cb then task.spawn(cb, value) end
end

function Config:GetFlag(flag: string, default: any?): any
    local v = _flags[flag]
    if v == nil then return default end
    return v
end

function Config:OnChanged(flag: string, cb: (any) -> ())
    _callbacks[flag] = cb
end

function Config:Register(flag: string, element: any)
    _elements[flag] = element
end

-- ini yg dipake di luar: AnimulaUI.Flags["myFlag"].Value
Config.Flags = {} :: { [string]: { Value: any } }

setmetatable(Config.Flags, {
    __index = function(_, key: string)
        local v = _flags[key]
        if v ~= nil then
            return { Value = v }
        end
        return nil
    end,
    __newindex = function(_, key: string, val: any)
        local value = if typeof(val) == "table" and (val :: any).Value ~= nil
            then (val :: any).Value
            else val
        Config:SetFlag(key, value)
    end,
})

-- save/load ke file (cuma jalan di executor yg support writefile)
function Config:SaveToFile(folder: string, fileName: string)
    local ok = pcall(function()
        if not isfolder(folder) then makefolder(folder) end
        writefile(folder .. "/" .. fileName .. ".json",
            game:GetService("HttpService"):JSONEncode(_flags))
    end)
    return ok
end

function Config:LoadFromFile(folder: string, fileName: string): boolean
    local ok, result = pcall(function()
        local raw = readfile(folder .. "/" .. fileName .. ".json")
        return game:GetService("HttpService"):JSONDecode(raw)
    end)
    if ok and typeof(result) == "table" then
        for k, v in pairs(result :: any) do
            Config:SetFlag(k, v)
        end
        return true
    end
    return false
end

-- buat debug aja
Config._raw = _flags

return Config
