local msg = "the cake is a lie"
local cur = false
local last = false

function flush()
    redstone.setOutput("back", true)
    while true do
        local event = os.pullEvent("redstone")

        if redstone.getInput("front") then
            redstone.setOutput("back", false)
            break
        end
    end

    --TODO remove later ?
    redstone.setOutput("left", false)
    redstone.setOutput("right", false)
end

function sendTwoBits(bitZero, bitOne)
    if bitZero then
        redstone.setOutput("left", true)
    else
        redstone.setOutput("left", false)
    end

    if bitOne then
        redstone.setOutput("right", true)
    else
        redstone.setOutput("right", false)
    end

    flush()
end

--char as int
function charToBinary(msgChar)
    local remain = msgChar
    local translation = {}
    local x = 0
    for i = 7, 0, -1 do
        curNum = i^2
        if (remain >= curNum) then
            translation[x] = 1
            remain = remain - curNum
        else
            translation[x] = 0
        end
        x = x + 1
    end
    return translation
end

--char as int
function sendChar(msgChar)
    local binChar = charToBinary(msgChar)
    for i = 0, 7, 2 do
        sendTwoBits(binChar[i], binChar[i+1])
    end
end

for k, v in pairs(charToBinary(123)) do
    --io.write(k..":"..v.." ")
    io.write(v)
end
print()

--sendTwoBits(false, true)
sendChar(121)
