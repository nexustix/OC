local curFront = 0
local lastFront = 0
local dbg = false

local component = require("component")
local redstone = component.redstone

local event = require("event")
local sides = require("sides")

local modem = require("modem")

modem.open(3587)


function debug(message)
    if dbg then
        print(message)
    end
end

function flush()
    --debug("flushing")
    redstone.setOutput(sides.back, 15)

    while true do
        curFront = redstone.getInput(sides.front)

        -- low to high
        if (curFront > 0) and (curFront ~= lastFront) then
            --debug("low high")

            redstone.setOutput(sides.left, 0)
            redstone.setOutput(sides.right, 0)
            redstone.setOutput(sides.back, 0)

        -- high to low
    elseif (not (curFront > 0)) and (curFront ~= lastFront) then
            lastFront = curFront
            break
        end

        lastFront = curFront
        --local event = os.pullEvent("redstone")
        local event = event.pull(nil, "redstone")
    end
end


function sendTwoBits(bitZero, bitOne)
    ---debug("setting")
    if bitZero then
        --redstone.setOutput(sides.left, 15)
        redstone.setOutput(sides.right, 15)
    --else
        --redstone.setOutput(sides.left, 0)
        --redstone.setOutput(sides.right, 0)
    end

    if bitOne then
        --redstone.setOutput(sides.right, 15)
        redstone.setOutput(sides.left, 15)
    --else
        --redstone.setOutput(sides.right, 0)
        --redstone.setOutput(sides.left, 0)
    end

    flush()
end

--char as int
function charToBinary(msgChar)
    local remain = msgChar
    local translation = {}
    local x = 1
    for i = 7, 0, -1 do
        curNum = 2^i
        --print(curNum)
        if (remain >= curNum) then
            translation[x] = true
            remain = remain - curNum
        else
            translation[x] = false
        end
        x = x + 1
    end
    return translation
end

--char as int
function sendChar(msgChar)
    local binChar = charToBinary(msgChar)
    for i = 1, 8, 2 do
        sendTwoBits(binChar[i], binChar[i+1])
    end
end

function sendString(message)
    for i = 1, message:len(), 1 do
        --print(msg:byte(i))
        sendChar(message:byte(i))
    end
end

function sendFile(filepath)
    --local tmpFile = io.open(filepath, "r")
    local lineNumber = 1
    for line in io.lines(filepath) do
        debug("line "..tostring(lineNumber))
        sendString(line.."\n")
        lineNumber = lineNumber + 1
    end

end

--local charTest = false
--local messageTest = true
--local fileTest = false
--local tmpChar = 121

while true do
    local _, _, from, port, _, message = event.pull("modem_message")
    sendString(tostring(message))
end

--[[
if charTest then
    for k, v in pairs(charToBinary(tmpChar)) do
        if v then
            --io.write("1")
            print(k.." ".."1")
        else
            --io.write("0")
            print(k.." ".."0")
        end
    end
    print()
    sendChar(tmpChar)
elseif messageTest then
    sendString("this is a test")

elseif fileTest then
    sendFile("test")
else
    sendTwoBits(true, true)
    sendTwoBits(false, false)
    sendTwoBits(false, true)
    sendTwoBits(true, false)
end

--]]--
