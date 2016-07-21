local buffer = {}
local index = 0
local curBack = false
local lastBack = false

local dbg = true

function debug(message)
    if dbg then
        print(message)
    end
end

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
