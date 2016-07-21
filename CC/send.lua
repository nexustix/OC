local msg = "the cake is a lie"

function flush()
    redstone.setOutput("back", 1)
    redstone.setOutput("back", 0)
end

function sendTwoBits(bitZero, bitOne)
    if bitZero then
        redstone.setOutput("left", 1)
    else
        redstone.setOutput("left", 0)
    end

    if bitOne then
        redstone.setOutput("right", 1)
    else
        redstone.setOutput("right", 0)
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
    io.write(k..":"..v.." ")
end
print()
