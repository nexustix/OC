local shell = require("shell")
local fs = require("filesystem")


fs.mount("8c9", "/home/nexustix")
shell.execute("cd /home/nexustix")

shell.execute("cp /home/nexustix/subs.dwl /home/nexustix/tmp.dwl")

local subs = io.open("/home/nexustix/tmp.dwl", "r")
local prefix = "https://raw.githubusercontent.com/nexustix/OC/master/"

while true do

    local line = subs:read("*l")

    if (line ~= nil) then --and (line ~= "") then
        --shell.execute("wget -f "..line)
        shell.execute("wget -f "..prefix..line)
    else
        break
    end
end

shell.execute("rm /home/nexustix/tmp.dwl")
