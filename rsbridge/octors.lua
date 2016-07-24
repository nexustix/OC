local curFront = 0
local lastFront = 0
local dbg = false

--local component = require("component")
--local redstone = component.redstone
local redstone = component.proxy(component.list("redstone")())

--local event = require("event")
--local sides = require("sides")

local sides = {}

sides.left = 5
sides.right = 4
sides.front = 3
sides.back = 2

--local modem = component.modem
local modem = component.proxy(component.list("modem")())

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
        --local event = event.pull(nil, "redstone")
        local event = computer.pullSignal(nil, "redstone")
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

while true do
    --local _, _, from, port, _, message = event.pull("modem_message")
    local _, _, from, port, _, message = computer.pullSignal(nil, "modem_message")
    if message ~= nil then
        sendString(tostring(message))
    end
end
