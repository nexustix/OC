local floodmesh = require("floodmesh")

-- create socket, given port
fm = floodmesh.new(8080)

-- start listening for incomming messages (in background)
fm:listen()

-- receive message (blocking)
local sender_uid, message = fm:receive()
print(message)

-- send message
fm:broadcast("the cake is a lie")
