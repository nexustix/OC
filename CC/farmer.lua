while true do
    local success, data = turtle.inspectUp()

    if success then
      print("Block name: ", data.name)
      print("Block metadata: ", data.metadata)
    end
end
