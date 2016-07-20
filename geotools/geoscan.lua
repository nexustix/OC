local component = require("component")
local slz = require("serialization")
local fs = require("filesystem")

function writeln(src, dest)
    dest:write(src)
    dest:write("\n")
end

function addValue(val, dest)
    local slzVar = slz.serialize(val)
    writeln(slzVar, dest)
end

function move(direction, curX, curY)
    local tmpX = curX
    local tmpY = curY
    if direction == "" then
    elseif direction == "up" then
        tmpY = tmpY + 1
    elseif direction == "down" then
        tmpY = tmpY - 1
    elseif direction == "left" then
        tmpX = tmpX - 1
    elseif direction == "right" then
        tmpX = tmpX + 1
    end
    return tmpX, tmpY
end

function scan(intensity, x, y)
    local result = geo.scan(x, y)

    for i in range(intensity) do
        local addResult = geo.scan(x, y)
        for k,v in pairs(result) do
            --print(k ..": "..v)
            result[k] = result[k] + addResult[k]
        end
    end

    for k,v in pairs(result) do
        --print(k ..": "..v)
        result[k] = result[k] / (intensity + 1)
    end

    return result
end

local configpath = "geo.cfg"
local config = {}

config["curX"] = 0
config["curY"] = 0

if not fs.exists("configpath") then
    file = io.open(configpath,"w")
    addValue(config, file)
    file:close()
end

file = io.open(configpath, "r")
config = slz.unserialize(file:read("*l"))


--local geo = component.geolyzer

--local curX = 0
--local curY = 0

--local result = {}


--[[
--HACK for testing
while true do
    result = geo.scan(curX, curY)

    for k,v in pairs(result) do
        print(k ..": "..v)
    end

    break
end
]]--

print(config)
