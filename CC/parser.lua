rednet.open("back")
shell.run("clear")

local buffer = io.open("buffer.buff", "w")
--local monitor = peripheral.wrap( "bottom" )
--monitor.clear()
--term.setCursorPos(1,1)


while true do
    event, senderId, message, protocol = os.pullEvent("rednet_message")
    --print( "Computer: "..senderId.." sent a message: "..message.." using "..protocol )
    --if (message >= 32) then
        --io.write(string.char(message))
        --monitor.write(string.char(message))
        print("<-> "..message.." >"..string.char(message).."<")
    --else
        --shell.run("clear")
    --end

    buffer:write(string.char(message))
end
