local nxpacket = {}

-- checks if package contains node entry with given id
function nxpacket.isContainingID(the_package, the_id)
    for k, v in pairs(the_package.nodes) do
        if (v == the_id) then
            return true
        end
    end
    return false
end

-- adds node entry to package
function nxpacket.addID(the_package, the_id)
    --the_package.nodes[the_id] = true
    the_package.nodes[#the_package.nodes+1] = the_id
    return the_package
end

-- creates new package
function nxpacket.wrap(the_message)
    local tmp_package = {}

    tmp_package.nodes = {}
    tmp_package.lifetime = 0
    tmp_package.maxlifetime = 0
    tmp_package.id = "nil"
    tmp_package.data = the_message

    return tmp_package
end

-- returns data part of package
function nxpacket.unwrap(the_package)
    return the_package.data
end

-- ducttape way to check if table is a package
function nxpacket.isPacket(the_package)
    if not the_package then
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

    if  hasKey(the_package, "nodes") and
        hasKey(the_package, "lifetime") and
        hasKey(the_package, "maxlifetime") and
        hasKey(the_package, "id") and
        hasKey(the_package, "data") then
            return true
    end
    return false
end

-- Open OS dependent way to serialize package to string
function nxpacket.ossSerialize(the_package)
    local srs = require("serialization")
    return srs.serialize(the_package)
end

-- Open OS dependent way to unserialize string to package
function nxpacket.oosUnserialize(the_message)
    local srs = require("serialization")
    return srs.unserialize(the_message)
end

-- Open OS dependent way to broadcast package
function nxpacket.oosBroadcastPackage(the_package, the_port)
    --local the_port = port or 8888
    local component = require("component")
    local modem = component.modem
    modem.broadcast(the_port, nxpacket.ossSerialize(the_package))
end

-- Open OS dependent way to broadcast message
function nxpacket.oosBroadcastMessage(the_message, the_port)
    local tmp_package = nxpacket.wrap(the_message)
    nxpacket.oosBroadcastPackage(tmp_package, the_port)
end

-- blocking Open OS dependent way to receive package
function nxpacket.oosReceivePackage(the_port)
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
    return nxpacket.oosReceivePackage(the_port).data
end

---[[
function nxpacket.test()
    -- expecting:
    -- false
    -- true

    local testpacket = nxpacket.wrap("the cake is a lie")

    assert(nxpacket.isPacket(testpacket) == true, "<!> packet check - failed")
    assert(nxpacket.isPacket({}) == false, "<!> empty packet test - failed")
    assert(nxpacket.isPacket({package=false}) == false, "<!> not-a-package test - failed")

    testpacket = nxpacket.addID(testpacket, "cafe")

    assert(nxpacket.isContainingID(testpacket, "cafe") == true,"<!> should contain id test - failed")
    assert(nxpacket.isContainingID(testpacket, "beef") == false,"<!> should NOT contain id test - failed")
end
---]]

nxpacket.test()
return nxpacket
