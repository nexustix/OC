local shell = require("shell")

local disk_id = "b51"
local disk_path = "/mnt/"..disk_id

local cur_command = ""

function runshow(the_command)
    print("<X>"..the_command.."<")
    shell.execute(the_command)
end

runshow("rm -r "..disk_path.."/*")
runshow("mkdir "..disk_path.."/lib")
runshow("mkdir "..disk_path.."/bin")
runshow("cp -i /home/".."nxpacket.lua".." "..disk_path.."/lib/")
runshow("cp -i /home/".."floodmesh.lua".." "..disk_path.."/lib/")

runshow("cp -i /home/".."nxpkdbg.lua".." "..disk_path.."/bin/")
runshow("cp -i /home/".."fm_test_client.lua".." "..disk_path.."/bin/")
runshow("cp -i /home/".."fm_test_server.lua".." "..disk_path.."/bin/")
