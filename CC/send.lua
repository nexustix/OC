local msg = "the cake is a lie"

function flush()
    redstone.setOutput("back", true)
    redstone.setOutput("back", false)
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

for k, v in pairs(charToBinary(123)) do
    --io.write(k..":"..v.." ")
    io.write(v)
end
print()

sendTwoBits(0, 1)
