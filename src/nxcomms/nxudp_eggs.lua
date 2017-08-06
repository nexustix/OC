local nxudp = require("nxpacket")

while true do
    print(nxudp.oosReceiveMessage(8080))
end
