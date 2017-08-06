local component = require("component")
local event = require("event")

local modem = component.modem

local computer = require("computer")
local srs = require("serialization")

package.path = "../../lib/?.lua;" .. package.path
local nxpkg = require("nxpacket")


function powerPercent() -- number: fuelPercent
    return (computer.energy() / (computer.maxEnergy() / 100))
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

function hasVaue(the_table, value)
    if (not (the_table == nil)) then
        for k,v in pairs(the_table) do
            if v == value then
                return true
            end
        end
    end
    return false
end

function getID()
    return string.sub(computer.address(),1,8)
end

--print(powerPercent())
--print(getID())
--print(computer.address())

modem.open(8080)
print("<-> Starting nxarpanet wireless relay")
while true do
    if (powerPercent() >= 50) then
        print("<-> receiving")
        local _, _, from, port, _, message = event.pull("modem_message")
        --print("Got a message from " .. from .. " on port " .. port .. ": " .. tostring(message))

        local tmp_packet = srs.unserialize(tostring(message))
        if (hasKey(tmp_packet, "nodes") and hasKey(tmp_packet, "data")) then
            print("<I> received package shaped message")
            print(">"..tostring(message).."<")


            if (not (nxpkg.isContainingID(tmp_packet, getID))) then
                print("<O> relaying")
                --tmp_packet.nodes[#tmp_packet.nodes+1] = getID()
                tmp_packet = nxpkg.addID(tmp_packet, getID())
                local reserialized_msg = srs.serialize(tmp_packet)
                print("<O> "..tostring(srs.unserialize(reserialized_msg)))
                modem.broadcast(8080, reserialized_msg)
            else
                print("<-> already seen")
            end
        else
            print("<!> received malformed message")
            print(">"..tostring(message).."<")
        end
    else
        print("<!> need more power -> sleeping")
        os.sleep(3)
    end
end
