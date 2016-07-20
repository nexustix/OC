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

function move(direction, curState)
    if direction == "" then
    elseif direction == "up" then
        curState["curY"] = curState["curY"] + 1
    elseif direction == "down" then
        curState["curY"] = curState["curY"] - 1
    elseif direction == "left" then
        curState["curX"] = curState["curX"] - 1
    elseif direction == "right" then
        curState["curX"] = curState["curX"] + 1
    end
end

local configpath = "geo.cfg"
local config = {}

stdConfig["curX"] = 0
stdConfig["curY"] = 0

if not fs.exists("configpath") then
    file = io.open(configpath,"w")
    addValue(config, file)
    file:close()
end

file = io.open(configpath, "r")
config = slz.unserialize(file:read("*l"))

print(config)

local geo = component.geolyzer

function getLast()

end

local filename = "test"

local curX = 0
local curY = 0

local result = {}



--HACK for testing
while true do
    result = geo.scan(curX, curY)

    for k,v in pairs(result) do
        print(k ..": "..v)
    end

    break
end
