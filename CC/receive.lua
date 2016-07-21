local buffer = {}
local index = 0

while true do
    redstone.setOutput("front", false)

    local event = os.pullEvent("redstone")
    if redstone.getInput("back") then
        buffer[index] = redstone.getInput("right")
        buffer[index+1] = redstone.getInput("left")
        index = index + 2
        redstone.setOutput("front", true)

        for k,v in pairs(buffer) do
            io.write(tostring(v))
        end
        print()
    end
end
