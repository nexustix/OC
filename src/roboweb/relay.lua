---------------------
--BOILERPLATE BEGIN--
---------------------
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
local wl = component.proxy(component.list("modem")())

local port = 3500

local msgBuff = {}
local msgPointer = 0
local msgMax = 8

function addMessage(theMessage)
    msgBuff[msgPointer] = theMessage
    msgBuff = msgBuff + 1
    msgBuff = msgBuff % msgMax
end

function sendMessage(theMessage)
    wl.broadcast(theMessage)
end

function sendAllMessages()
    for k,v in pairs(msgBuff) do
        sendMessage(v)
        msgBuff[v] = nil
    end
end

function hasEnoughPower()
    if computer.energy > 10000 then
        return true
    end
    return false
end

function beepYes()
    computer.beep(200,1)
    computer.beep(255)
end

function beepNo()
    computer.beep(255)
    computer.beep(200,1)
end

wl.open(port)

while true do
    local ev, lAdress, rAdress, port, distance, message = computer.pullSignal()
    --local _, _, from, port, _, message = event.pull("modem_message")
    if ev == "modem_message" then

        local tmpPacket = unserialize(message)
        if isPaket(tmpPacket) then
            beepYes()
        else
            beepNo()
        end
    else
        beepNo()
    end
    --print("Got a message from " .. from .. " on port " .. port .. ": " .. tostring(message))
end
