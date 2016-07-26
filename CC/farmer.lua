while true do
    local success, data = turtle.inspectUp()

    if success then
      print("U Block name: ", data.name)
      print("U Block metadata: ", data.metadata)
    else
        --trying to reset turtle to rail
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.forward()
    end

    function farm()
        local success_1, data_1 = turtle.inspectDown()
        if success_1 then
            if data_1.metadata >= 7 then
                turtle.digDown()
                turtle.placeDown()
            end
        else
            turtle.placeDown()
        end

    end

    function dumpItems()
        for i = 1, 16 do
            turtle.select(i)
            if not turtle.dropDown() then
                break
            end
        end
        turtle.select(1)
    end

    function pickFuel()
        if turtle.getFuelLevel() <= (turtle.getFuelLimit() - 1000) then
            turtle.suckDown()
            turtle.refuel()
            turtle.dropDown()
        end
        if turtle.getFuelLevel() >= 1000 then
            return true
        else
            return false
        end
    end

    if data.name == "minecraft:stone" then
        --Andersite
        if (data.metadata == 6) then
            --turtle.digDown()
            farm()
            turtle.forward()

        --Diorite
        elseif (data.metadata == 4) then
            turtle.turnLeft()
            turtle.forward()

        --Granite
        elseif (data.metadata == 2) then
            turtle.turnRight()
            turtle.forward()
        end

    elseif data.name == "minecraft:prismarine" then
        dumpItems()
        turtle.forward()

    elseif data.name == "minecraft:nether_brick" then
        if pickFuel() then
            turtle.forward()
        else
            os.sleep(10)
        end
    end

    os.sleep(2)
end
