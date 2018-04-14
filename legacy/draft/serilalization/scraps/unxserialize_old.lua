
--local outtest

--HACK verry hacky solution


function resizeString(theString, theSize)
    tmpString = theString
    fillChar = "-"
    if string.len(tmpString) > theSize then
        error("string: >"..theString.."< too long")
    end
    --HACK
    while string.len(tmpString) < theSize do
        tmpString = tmpString .. fillChar
    end
    return tmpString
end

function makeSegment(theKey, theData)
    local tmpString = ""
    local dataString = tostring(theData)

    tmpString = tmpString .. resizeString(theKey, 8)                  --key
    tmpString = tmpString .. resizeString(type(theData), 8)           --type
    tmpString = tmpString .. resizeString(string.len(dataString), 8)  --length
    tmpString = tmpString .. dataString                             --data

    return tmpString
end

function unmakeSegment(theSegment)
end

--testa = {}

--print(">"..tostring(testa).."<")
tmpData = makeSegment("testkey", "the cake is a lie")
print(string.len(tmpData))
print(">"..tmpData.."<")
