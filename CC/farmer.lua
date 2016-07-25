while true do
    local success, data = turtle.inspectUp()

    if success then
      print("U Block name: ", data.name)
      print("U Block metadata: ", data.metadata)
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
    end

    os.sleep(0.25)
end
