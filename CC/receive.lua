local buffer = {}
local index = 0
local curBack = false
local lastBack = false

local dbg = false

function debug(message)
    if dbg then
        print(message)
    end
end

function writeBit(boolValue)
    if boolValue then
        io.write("1")
    else
        io.write("0")
    end
end

function receiveTwoBits()
    debug("receiving")
    local inLeft, inRight
    inLeft = redstone.getInput("left")
    inRight = redstone.getInput("right")
    debug("got "..tostring(inLeft) .." ".. tostring(inRight))
    if not dbg then
        --io.write(tostring(inLeft).." "..tostring(inRight).." ")
        writeBit(inLeft)
        writeBit(inRight)
    end
end

while true do
    curBack = redstone.getInput("back")

    -- low to high
    if curBack and (curBack ~= lastBack) then
        debug("low high")
        receiveTwoBits()
        redstone.setOutput("front", true)
    --end

    -- high to low
    elseif (not curBack) and (curBack ~= lastBack) then
        debug("high low")
        redstone.setOutput("front", false)
    end

    lastBack = curBack
    --os.sleep(0.1)
    local event = os.pullEvent("redstone")
end

--[[
--print()
while true do
    debug("waiting")
    local event = os.pullEvent("redstone")
    curBack = redstone.getInput("back")
    if (curBack) and (curBack ~= lastBack) then
        lastBack = true
        buffer[index] = redstone.getInput("right")
        buffer[index+1] = redstone.getInput("left")
        index = index + 2
        redstone.setOutput("front", true)

        --io.write("\f")
        for k,v in pairs(buffer) do
            --if v == true then
                --io.write(1)
            --else
                --io.write(0)
            --end
            io.write(tostring(v).." ")
        end
        print()
    elseif not curBack then
        debug("else if")
        lastBack = false
        redstone.setOutput("front", false)
    else
        debug("else")
        --redstone.setOutput("front", false)
    end
    --os.sleep(0.1)
end
--]]
