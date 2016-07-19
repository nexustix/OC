local component = require("component")

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
