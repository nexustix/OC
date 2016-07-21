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
    for i = 7, 0, -1 do
        if (remain >= curNum) then
            translation[i] = 1
        else
            translation[i] = 0
        end
    end
    return translation
end

for k, v in pairs(charToBinary(123)) do
    io.write(v)
end
print()
