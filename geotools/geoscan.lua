local component = require("component")
local slz = require("serialization")

function writeln(src, dest)
    dest:write(src)
    dest:write("\n")
end

function addValue(val, dest)
    local slzVar = slz.serialize(val)
    writeln(slzVar, dest)
end

local configpath = "geo.cfg"
local stdConfig = {}

stdConfig["cake"] = "lie"

if false then
    file = io.open(configpath,"w")
    addValue(stdConfig)
    file:close()
end

file = io.open(configpath, "r")

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
