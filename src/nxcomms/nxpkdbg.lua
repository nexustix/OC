local nxudp = require("nxpacket")
local srs = require("serialization")

local args = ...

local the_port = tonumber(args[1])

print("<-> debugging packets on port "..tostring(the_port))

while true do
    local tmp_packet = nxudp.oosReceivePacket(the_port)

    print("=====")
    print(srs.serialize(tmp_packet), true)
end
