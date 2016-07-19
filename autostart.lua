local shell = require("shell")

local subs = io.open("/home/nexustix/subs.dwl", "r")

while true do

    local line = subs:read("*l")

    if (line ~= nil) then --and (line ~= "") then
        shell.execute("wget -f "..line)
    else
        break
    end
end
