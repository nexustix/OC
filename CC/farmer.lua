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
            end
          --print("D Block name: ", data_1.name)
          --print("D Block metadata: ", data_1.metadata)
        end
    end

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

    os.sleep(0.25)
end
