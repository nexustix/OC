

a_string = "((witch true)(menu (0 spam)(1 eggs))(colour blue)(max_speed 42))"

function deserialize(theString)
    local f = theString:sub(1,1)
    local curType = ""
    local curData = ""

    if f == "(" then
        curType = "list"
    elseif f == ")" then
        error("what ??")
    elseif f == "'" then
        curType = "string"
    else
        curType = "atom"
    end

    print("parsing "..curType)

    for i = 2, #theString do
        local c = theString:sub(i,i)
        if curType == "list" then
            curData = curData .. c
            if c == ")" then
                print(curData)
            else
                print(c)
            end
        end
    end
end

deserialize(a_string)
