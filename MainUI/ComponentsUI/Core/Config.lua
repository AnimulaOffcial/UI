--!strict
-- config / flags buat animula ui
-- konsep nya kayak orion: tiap element punya Flag, terus bisa di akses via Flags[flag].Value
-- gw tambahin save/load ke file juga biar gak ilang pas rejoin

local HttpService = game:GetService("HttpService")

local Config = {}

local _flags:     { [string]: any }         = {}
local _callbacks: { [string]: (any) -> () } = {}
local _elements:  { [string]: any }         = {} -- ref ke element object nya
local _proxies:   { [string]: any }         = {}

local function encodeValue(value: any): any
    local kind = typeof(value)
    if kind == "Color3" then
        local color = value :: Color3
        return {
            __animula_type = "Color3",
            r = color.R,
            g = color.G,
            b = color.B,
        }
    elseif kind == "EnumItem" then
        local item: any = value
        return {
            __animula_type = "EnumItem",
            enum = tostring(item.EnumType),
            name = item.Name,
        }
    elseif kind == "table" then
        local result: { [any]: any } = {}
        for key, item in pairs(value :: { [any]: any }) do
            local encoded = encodeValue(item)
            if encoded ~= nil then result[key] = encoded end
        end
        return result
    elseif kind == "string" or kind == "number" or kind == "boolean" then
        return value
    end
    return nil
end

local function decodeValue(value: any): any
    if typeof(value) ~= "table" then return value end

    local data: any = value
    if data.__animula_type == "Color3" then
        local r, g, b = tonumber(data.r), tonumber(data.g), tonumber(data.b)
        if r and g and b then return Color3.new(r, g, b) end
    elseif data.__animula_type == "EnumItem" and type(data.enum) == "string" and type(data.name) == "string" then
        local enumName = string.match(data.enum, "^Enum%.(.+)$")
        local enumTable: any = enumName and (Enum :: any)[enumName]
        local item = enumTable and enumTable[data.name]
        if item then return item end
    end

    local result: { [any]: any } = {}
    for key, item in pairs(data) do
        result[key] = decodeValue(item)
    end
    return result
end

-- `fromElement` prevents a widget's own setter from being invoked again when
-- it reports a user interaction back to Config. External flag writes still
-- call the widget setter so the visual control and its state stay in sync.
function Config:SetFlag(flag: string, value: any, fromElement: boolean?)
    _flags[flag] = value
    local el = _elements[flag]
    if el and not fromElement and type((el :: any).Set) == "function" then
        (el :: any):Set(value)
        return
    elseif el then
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

function Config:HasFlag(flag: string): boolean
    return _flags[flag] ~= nil
end

-- Use the stored value when a config file was loaded before the UI was built.
function Config:Initialize(flag: string, default: any): any
    if _flags[flag] == nil then
        Config:SetFlag(flag, default)
    end
    return _flags[flag]
end

function Config:OnChanged(flag: string, cb: (any) -> ())
    _callbacks[flag] = cb
end

function Config:Register(flag: string, element: any)
    _elements[flag] = element
    if _flags[flag] ~= nil then
        if type(element.Set) == "function" then
            element:Set(_flags[flag])
        else
            element.Value = _flags[flag]
        end
    end
end

-- ini yg dipake di luar: AnimulaUI.Flags["myFlag"].Value
Config.Flags = {} :: { [string]: { Value: any } }

local function getProxy(key: string): any
    local proxy = _proxies[key]
    if proxy then return proxy end

    proxy = {}
    setmetatable(proxy, {
        __index = function(_, field: string)
            if field == "Value" then return _flags[key] end
            return nil
        end,
        __newindex = function(_, field: string, value: any)
            if field == "Value" then
                Config:SetFlag(key, value)
            else
                rawset(proxy, field, value)
            end
        end,
    })
    _proxies[key] = proxy
    return proxy
end

setmetatable(Config.Flags, {
    __index = function(_, key: string)
        if _flags[key] == nil then return nil end
        return getProxy(key)
    end,
    __newindex = function(_, key: string, val: any)
        local value = if typeof(val) == "table" and (val :: any).Value ~= nil
            then (val :: any).Value
            else val
        Config:SetFlag(key, value)
    end,
})

-- save/load ke file (cuma jalan di executor yg support writefile)
function Config:SaveToFile(folder: string, fileName: string): boolean
    local ok = pcall(function()
        if type(writefile) ~= "function" then error("writefile is unavailable") end
        if type(isfolder) == "function" and not isfolder(folder) then
            if type(makefolder) ~= "function" then error("makefolder is unavailable") end
            makefolder(folder)
        end

        local saved: { [string]: any } = {}
        for flag, value in pairs(_flags) do
            local element = _elements[flag]
            if element == nil or (element :: any).Save == true then
                local encoded = encodeValue(value)
                if encoded ~= nil then saved[flag] = encoded end
            end
        end
        writefile(folder .. "/" .. fileName .. ".json", HttpService:JSONEncode(saved))
    end)
    return ok
end

function Config:LoadFromFile(folder: string, fileName: string): boolean
    local ok, result = pcall(function()
        if type(readfile) ~= "function" then error("readfile is unavailable") end
        local raw = readfile(folder .. "/" .. fileName .. ".json")
        return HttpService:JSONDecode(raw)
    end)
    if ok and typeof(result) == "table" then
        for key, value in pairs(result :: any) do
            Config:SetFlag(key, decodeValue(value))
        end
        return true
    end
    return false
end

-- buat debug aja
Config._raw = _flags

return Config
