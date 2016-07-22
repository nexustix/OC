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
    debug("flushing")
    redstone.setOutput("back", true)

    while true do
        curFront = redstone.getInput("front")

        -- low to high
        if (curFront) and (curFront ~= lastFront) then
            debug("low high")
            redstone.setOutput("back", false)
        --end

        -- high to low
        elseif (not curFront) and (curFront ~= lastFront) then
            debug("n high low")
            --redstone.setOutput("back", false)
            lastFront = curFront
            break
        end

        lastFront = curFront
        --os.sleep(0.1)
        local event = os.pullEvent("redstone")
    end
end

--[[
function flush()
    debug("flushing")
    redstone.setOutput("back", true)
    while not redstone.getInput("front") do
        local event = os.pullEvent("redstone")

        --if redstone.getInput("front") then

            --break
        --end
    end
    redstone.setOutput("back", false)

    --TODO remove later ?
    redstone.setOutput("left", false)
    redstone.setOutput("right", false)
end
]]--

function sendTwoBits(bitZero, bitOne)
    debug("setting")
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
        print(curNum)
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



--for k, v in pairs(charToBinary(123)) do
    --io.write(k..":"..v.." ")
    --io.write(v)
--end
--print()


local charTest = false
local messageTest = true
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
    for i = 1, msg:len(), 1 do
        print(msg:byte(i))
    end
else
    sendTwoBits(true, true)
    sendTwoBits(false, false)
    sendTwoBits(false, true)
    sendTwoBits(true, false)
end
