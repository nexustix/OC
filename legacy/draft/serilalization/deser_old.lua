
a_string = "(foo bar)"
b_string = "(menu (0 spam)(1 eggs))"
c_string = "(cakeislie true)(menu (0 spam)(1 eggs))(favcolour blue)(answer 42)"

function parseSegment(theString)
    local tmpTable = {}
    local tmpKey = ""
    local tmpVal = ""
    local atKey = true
    local level = 1
    for i = 2, #theString do
        local c = theString:sub(i,i)
        print(c)

        if c == ")" then
            level = level - 1
            if level == 0 then
                --if tmpVal:sub(1,1) == "(" then

                --else
                tmpTable[tmpKey] = tmpVal
                return tmpTable, i
                --end
                --return tmpKey, tmpVal, i
            else
                tmpVal = tmpVal .. c
            end
        elseif c == "(" then
            level = level + 1
            tmpVal = tmpVal .. c
        elseif c == " " then
            if level == 1 then
                atKey = false
            else
                tmpVal = tmpVal .. c
            end

        else
            if atKey then
                tmpKey = tmpKey .. c
            else
                tmpVal = tmpVal .. c
            end
        end
    end
end

function deserialize(theString)
    local f = theString:sub(1,1)
    local curType = ""
    local curData

    if f == "(" then
        curType = "list"
        curData = {}
    else
        curType = "atom"
        curData = ""
    end

    print("parsing "..curType)

    for i = 2, #theString do
        local c = theString:sub(i,i)
        print(c)

        if c == "(" then
            deserialize(theString:sub(i,#theString))
        end
    end

end

deserialize(a_string)

print(parseSegment(b_string))
