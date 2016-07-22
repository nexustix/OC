local buffer = {}
local index = 1
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

function writeByte(boolArray)
    for k,v in pairs(boolArray) do
        writeBit(v)
    end
    print()
end

function receiveTwoBits()
    debug("receiving")
    local inLeft, inRight
    inRight = redstone.getInput("right")
    inLeft = redstone.getInput("left")
    debug("got "..tostring(inLeft) .." ".. tostring(inRight))
    if not dbg then
        --io.write(tostring(inLeft).." "..tostring(inRight).." ")
        --writeBit(inRight)
        --writeBit(inLeft)
    end
    return inRight, inLeft
end

function binaryToChar(binArray)
    --local remain = msgChar
    local result = 0
    local x = 1
    for i = 7, 0, -1 do
        curNum = 2^i
        if binArray[x] then
            result = result + curNum
        --else
        end
        x = x + 1
    end
    return translation
end

while true do
    curBack = redstone.getInput("back")

    -- low to high
    if curBack and (curBack ~= lastBack) then
        debug("low high")
        buffer[index], buffer[index+1] = receiveTwoBits()
        index = index + 2
        redstone.setOutput("front", true)
    --end

    -- high to low
    elseif (not curBack) and (curBack ~= lastBack) then
        debug("high low")
        redstone.setOutput("front", false)
    end

    if #buffer == 8 then
        --print(binaryToChar())
        writeByte(buffer)
        buffer = {}
        index = 1
    elseif #buffer >= 8 then
        print("critical error")
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
