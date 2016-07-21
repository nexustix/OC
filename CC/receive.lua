local buffer = {}
local index = 0
local curBack = false
local lastBack = false

while true do
    local event = os.pullEvent("redstone")
    curBack =redstone.getInput("back")
    if (curBack) and (curBack ~= lastBack) then
        lastBack = true
        buffer[index] = redstone.getInput("right")
        buffer[index+1] = redstone.getInput("left")
        index = index + 2
        redstone.setOutput("front", true)

        for k,v in pairs(buffer) do
            io.write(tostring(v))
        end
        print()
    elseif not curBack then
        lastBack = false
        redstone.setOutput("front", false)
    end
end
