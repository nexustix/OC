--[[
function toString(theTable)
    --return serialize(theTable)
end

function fromString(theString)
    --return unserialize(theString)
end
]]--

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
