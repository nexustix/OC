---------------------
--BOILERPLATE BEGIN--
---------------------
-- returns new packet
function newPacket()
    local tmpTable = {}
    -- lifetime of packet
    tmpTable.lifetime = 0
    -- maximum lifetime of packet (0 = forever)
    tmpTable.maxLifetime = 0
    -- ID of packet
    tmpTable.id = ""
    -- metadata like protocol used
    tmpTable.meta = ""
    -- source adress of packet
    tmpTable.source = ""
    -- destination adress of packet
    tmpTable.destination = ""
    -- nodes already passed
    tmpTable.path = {}
    -- data section
    tmpTable.data = ""
    return tmpTable
end
-- checks if table is packet (kind of)
function isPaket(thePacket)
    if not thePacket then
        return false
    end

    function hasKey(the_table, key)
        if (not (the_table == nil)) then
            for k,v in pairs(the_table) do
                if k == key then
                    return true
                end
            end
        end
        return false
    end

    if  hasKey(thePacket, "lifetime") and
        hasKey(thePacket, "maxLifetime") and
        hasKey(thePacket, "id") and
        hasKey(thePacket, "meta") and
        hasKey(thePacket, "source") and
        hasKey(thePacket, "destination") and
        hasKey(thePacket, "path") and
        hasKey(thePacket, "data") then
            return true
    end
    return false
end

-- adds ID to packet
function addID(thePacket, theID)
    thePacket.path[#thePacket.path+1] = theID
    return thePacket
end

-- checks if packet has ID
function hasID(thePacket, theID)
    for k, v in pairs(thePacket.path) do
        if (v == theID) then
            return true
        end
    end
    return false
end
---------------------
--BOILERPLATE BEGIN--
---------------------
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
    return load("return "..theString)()
end
-------------------
--BOILERPLATE END--
-------------------
local c = require("component")
local wl = c.modem

--local wl = component.proxy(component.list("modem")())

while true do
    local tmpPacket = newPacket()
    print(isPaket(tmpPacket))
    local tmpString = serialize(tmpPacket)
    --wl.broadcast(3500, "foobar")
    wl.broadcast(3500, tmpString)
    os.sleep(3)
end
