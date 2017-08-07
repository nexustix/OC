local nxpacket = require("nxpacket")

local floodmesh = {}
floodmesh.__index = floodmesh


function floodmesh.new(the_port)
    local self = setmetatable({}, floodmesh)
    assert(not(the_port == nil), "<!> missing port argument in new()")
    self.port = the_port
    --queue of incomming packet-strings
    --self.in_queue = {}
    --queue of outgoing message-strings
    --self.out_queue = {}
    --self.maxhistory = 16
    --self.counter = 1
    self.history = {}
    self.maxhistory = 16
    self.counter = 1
    self.subs = {}
    self.resendtimeout = 0
    return self
end


function floodmesh.appendSeen(self, the_id)
    self.history[self.counter] = the_id
    self.counter = (self.counter + 1) % self.maxhistory
end


function floodmesh.isSeen(self, the_id)
    for k,v in pairs(self.history) do
        if v == the_id then
            return true
        end
    end
    return false
end


function floodmesh.listen(the_port)
    local event = require("event")
    local computer = require("computer")
    local thread = require("thread")
    while true do
        local tmp_packet = nxpacket.oosReceivePacket(the_port)
        if tmp_packet.destination == computer.adress() then
            if tmp_packet.kind == "echo" then
                event.push("floodmesh_echo", tmp_packet.id, tmp_packet.data)
            elseif tmp_packet.kind == "message" then
                event.push("floodmesh_message", tmp_packet.id, tmp_packet.data)
            end
        end
    end
end


function floodmesh.sendMessage(self, the_message)
    local event = require("event")

    local tmp_packet = nxpacket.wrap(the_message)
    tmp_packet.id = require("uuid").next()
    tmp_packet.kind = "message"
    nxpacket.oosBroadcastPacket(tmp_packet, self.port)

    local rtimeout = 0
    while true do
        local echo_id = event.pull(5, "floodmesh_echo")

        if echo_id == nil then
            nxpacket.oosBroadcastPacket(tmp_packet, self.port)
        elseif echo_id == tmp_packet.id then
            break
        else
            event.push("floodmesh_echo", echo_id)
        end

        if (not (self.resendtimeout == 0)) then
            if rtimeout >= self.resendtimeout then
                break
            else
                rtimeout = rtimeout + 1
            end
        end
    end
end


--[[
function floodmesh.receiveMessage(self, the_message)
    local event = require("event")
    local computer = require("computer")
    while true do
        local tmp_packet = nxpacket.oosReceivePacket()
        if tmp_packet.destination == computer.adress() then
            if tmp_packet.kind == "echo" then
                event.push("floodmesh_echo", tmp_packet.id)
            else

            end
        elseif  ((tmp_packet.destination == "na") and
                (tmp_packet.kind == "sub")) then
        end
    end
end
]]

return floodmesh
