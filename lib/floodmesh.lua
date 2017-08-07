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
    self.version = "floodmesh_0.0.1"
    self.msg_event_name = self.version .. "_message"
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


function floodmesh.listen(self)
    local event = require("event")
    --local computer = require("computer")
    local thread = require("thread")
    thread.create(function(tmp_port)
        local nxpacket = require("nxpacket")
        --print(tmp_port)
        while true do
            local tmp_packet = nxpacket.oosReceivePacket(tmp_port)
            local tmp_id = tmp_packet.id
            if tmp_packet.kind == self.msg_event_name then
                if (not(self:isSeen(tmp_packet.id))) then
                    --event.push(self.msg_event_name, tmp_packet.id, tmp_packet.data)
                    event.push(self.msg_event_name, tmp_packet.source, tmp_packet.data)
                    self:appendSeen(tmp_packet.id)
                end
            end
        end
    end, self.port)
end


function floodmesh.broadcast(self, the_message)
    local event = require("event")
    local tmp_packet = nxpacket.wrap(the_message)
    tmp_packet.id = require("uuid").next()
    tmp_packet.kind = self.msg_event_name
    nxpacket.oosBroadcastPacket(tmp_packet, self.port)
end


function floodmesh.receive(self)
    local event = require("event")
    local _, sender_uid, message = event.pull(self.msg_event_name)
    return sender_uid, message
end


return floodmesh
