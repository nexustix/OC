rednet.open("top")
shell.run("clear")

local buffer = io.open("buffer.buff", "w")

while true do
    event, senderId, message, protocol = os.pullEvent("rednet_message")
    --print( "Computer: "..senderId.." sent a message: "..message.." using "..protocol )
    if (message >= 32) then
        io.write(string.char(message))
    else
        shell.run("clear")
    end

    buffer:write(string.char(message))
end
