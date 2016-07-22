local msg = "the cake is a lie"
local curFront = false
local lastFront = false
local dbg = true

function debug(message)
    if dbg then
        print(message)
    end
end

function flush()
    --debug("flushing")
    redstone.setOutput("back", true)

    while true do
        curFront = redstone.getInput("front")

        -- low to high
        if (curFront) and (curFront ~= lastFront) then
            --debug("low high")
            redstone.setOutput("back", false)

        -- high to low
        elseif (not curFront) and (curFront ~= lastFront) then
            lastFront = curFront
            break
        end

        lastFront = curFront
        local event = os.pullEvent("redstone")
    end
end


function sendTwoBits(bitZero, bitOne)
    --debug("setting")
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

local charTest = false
local messageTest = false
local fileTest = true
local tmpChar = 121



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
    --for i = 1, msg:len(), 1 do
        --print(msg:byte(i))
        --sendChar(msg:byte(i))
    --end
elseif fileTest then
    sendFile("test")
else
    sendTwoBits(true, true)
    sendTwoBits(false, false)
    sendTwoBits(false, true)
    sendTwoBits(true, false)
end
