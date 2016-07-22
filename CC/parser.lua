rednet.open("top")
shell.run("clear")
while true do
  event, senderId, message, protocol = os.pullEvent("rednet_message")
  --print( "Computer: "..senderId.." sent a message: "..message.." using "..protocol )
  io.write(string.char(message))
end
