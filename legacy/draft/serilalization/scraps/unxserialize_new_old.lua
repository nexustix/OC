function makeSegment(theKey, theData)
    local tmpString = "("
    tmpString = tmpString .. theKey --.. ":"            --key
    tmpString = tmpString .. " "
    tmpString = tmpString .. tostring(theData) ..")"    --data
    return tmpString
end

function serialize(theTable)
    --local tmpString = "("
    local tmpString = ""
    for k,v in pairs(theTable) do
        if type(v) == "table" then
            tmpString = tmpString .. makeSegment(tostring(k), serialize(v))
        else
            --print(tostring(k).." "..tostring(v))
            tmpString = tmpString .. makeSegment(tostring(k), tostring(v))
        end
    end
    return tmpString
end

function unserialize(theString)
    print("START")
    local tmpTable = {}
    local curKey = ""
    local curVal = ""
    local curData = ""
    local atKey = true
    local curLevel = 0

    function addChar(theChar)
        if curLevel <= 1 then
            if atKey then
                curKey = curKey .. theChar
                return
            end
            curVal = curVal .. theChar
        end
    end

    function addData(theChar)
        curData = curData .. theChar
    end

    for i = 1, #theString do
        local c = theString:sub(i,i)
        print(c)
        --if curLevel <= 1 then
        if c == "(" then
            atKey = true
            curLevel = curLevel + 1

        elseif c == ")" then
            if curLevel == 1 then
                if #curData > 0 then
                    print(">>>"..curKey .." ".. curData)
                    --curData = curData .. ")"
                    tmpTable[curKey] = unserialize(curData)
                    --tmpTable[curKey] = "foo"
                    curKey = ""
                    curData = ""
                    --print("DING")
                end
            end
            if curLevel > 1 then
                addData(c)
            end
            if curLevel == 1 then
                print(">"..curKey .."< >"..curVal.."<")
                tmpTable[curKey] = curVal
                curKey = ""
                curVal = ""
            end
            print(">>>"..tostring(curLevel).."<<<")
            curLevel = curLevel - 1



        elseif c == " " then
            atKey = false
        else
            addChar(c)
        end

        if curLevel > 1 then
            addData(c)
        end
        --else
            --addChar(c)
        --end
    end
    --print(curData)
    print("STOP")
    return tmpTable

end

--testa = {}

--print(">"..tostring(testa).."<")
tmpData = makeSegment("testkey", "the cake is a lie")
print(string.len(tmpData))
print(">"..tmpData.."<")

tmpData = makeSegment("key", makeSegment("deeperkey", "the cake is a lie"))
print(string.len(tmpData))
print(">"..tmpData.."<")


testable = {
    ["menu"] = {
        [0]= "spam",
        [1]= "eggs",
    },
    ["colour"]="blue",
    ["witch"]=true,
    ["max_speed"]=42}

testables = {
    ["key"]="val",
    ["cakeislie"]=true}

print(type(testable))
tmpData = serialize(testable)
print(tmpData)
testa = unserialize(tmpData)

for k,v in pairs(testa) do

    print(">"..k .."< >"..tostring(v).."<")
end

--[[

(menu
    (0 spam)
    (1 eggs))
(witch true)
(max_speed 42)
(colour blue)

]]--
