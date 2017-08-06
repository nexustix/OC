local nxpacket = {}

-- checks if packet contains node entry with given id
function nxpacket.isContainingID(the_packet, the_id)
    for k, v in pairs(the_packet.nodes) do
        if (v == the_id) then
            return true
        end
    end
    return false
end

-- adds node entry to packet
function nxpacket.addID(the_packet, the_id)
    --the_packet.nodes[the_id] = true
    the_packet.nodes[#the_packet.nodes+1] = the_id
    return the_packet
end

-- creates new packet
function nxpacket.wrap(the_message)
    local tmp_packet = {}

    tmp_packet.nodes = {}
    tmp_packet.lifetime = 0
    tmp_packet.maxlifetime = 0
    tmp_packet.id = "nil"
    tmp_packet.data = the_message

    return tmp_packet
end

-- returns data part of packet
function nxpacket.unwrap(the_packet)
    return the_packet.data
end

-- ducttape way to check if table is a packet
function nxpacket.isPacket(the_packet)
    if not the_packet then
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

    if  hasKey(the_packet, "nodes") and
        hasKey(the_packet, "lifetime") and
        hasKey(the_packet, "maxlifetime") and
        hasKey(the_packet, "id") and
        hasKey(the_packet, "data") then
            return true
    end
    return false
end

-- Open OS dependent way to serialize packet to string
function nxpacket.ossSerialize(the_packet)
    local srs = require("serialization")
    return srs.serialize(the_packet)
end

-- Open OS dependent way to unserialize string to packet
function nxpacket.oosUnserialize(the_message)
    local srs = require("serialization")
    return srs.unserialize(the_message)
end

-- Open OS dependent way to broadcast packet
function nxpacket.oosBroadcastPacket(the_packet, the_port)
    --local the_port = port or 8888
    local component = require("component")
    local modem = component.modem
    modem.broadcast(the_port, nxpacket.ossSerialize(the_packet))
end

-- Open OS dependent way to broadcast message
function nxpacket.oosBroadcastMessage(the_message, the_port)
    local tmp_packet = nxpacket.wrap(the_message)
    nxpacket.oosBroadcastPacket(tmp_packet, the_port)
end

-- blocking Open OS dependent way to receive packet
function nxpacket.oosReceivePacket(the_port)
    --local the_port = port or 8888
    local component = require("component")
    local event = require("event")
    local modem = component.modem
    modem.open(the_port)
    while true do
        local _, _, from, port, _, message = event.pull("modem_message")

        local maybe_packet = nxpacket.oosUnserialize(message)
        if (nxpacket.isPacket(maybe_packet)) then
            --return maybe_packet.data
            return maybe_packet
        end
    end
end

-- blocking Open OS dependent way to receive message
function nxpacket.oosReceiveMessage(the_port)
    return nxpacket.oosReceivePacket(the_port).data
end

---[[
function nxpacket.test()
    -- expecting:
    -- false
    -- true

    local testpacket = nxpacket.wrap("the cake is a lie")

    assert(nxpacket.isPacket(testpacket) == true, "<!> packet check - failed")
    assert(nxpacket.isPacket({}) == false, "<!> empty packet test - failed")
    assert(nxpacket.isPacket({packet=false}) == false, "<!> not-a-packet test - failed")

    testpacket = nxpacket.addID(testpacket, "cafe")

    assert(nxpacket.isContainingID(testpacket, "cafe") == true,"<!> should contain id test - failed")
    assert(nxpacket.isContainingID(testpacket, "beef") == false,"<!> should NOT contain id test - failed")
end
---]]

nxpacket.test()
return nxpacket
