while true do
    local success, block = turtle.inspectUp()
    print(block)
    os.sleep(1)
end
