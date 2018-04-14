function wrapType(theData)
    if type(theData) == "string" then
        if theData:sub(1,1) == "{" then
            return theData
        end
        return "'" .. theData .. "'"
    else
        return tostring(theData)
    end
end

function makeSegment(theKey, theValue)
    local tmpString = ""

    local tmpKey = wrapType(theKey)
    local tmpValue = wrapType(theValue)

    tmpString = tmpString .. "[" .. tmpKey .. "]"       --key
    tmpString = tmpString .. "="
    tmpString = tmpString .. tostring(tmpValue) ..","   --data
    return tmpString
end

function serialize(theTable)
    local tmpString = "{"
    for k,v in pairs(theTable) do
        if type(v) == "table" then
            tmpString = tmpString .. makeSegment(k, serialize(v))
        else
            tmpString = tmpString .. makeSegment(k, v)
        end
    end
    tmpString = tmpString .. "}"
    return tmpString
end

function unserialize(theString)
    --HACK evil
    return load("return "..theString)() or {}
end

----[[
testable = {
    ["menu"] = {
        [0]= "spam",
        [1]= "eggs",
    },
    ["fav_colour"]="blue",
    ["cakeislie"]=true,
    ["answer"]=42}

testables = {
    ["key"]="val",
    ["cakeislie"]=true}

print(type(testable))
tmpData = serialize(testable)
print(tmpData)
testing = unserialize(tmpData)

for k,v in pairs(testing) do
    print(type(k).." >"..k .."< >"..tostring(v).."<")
end
--]]
