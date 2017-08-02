local comp = require("component")
local modem = comp.modem

local args = {...}

modem.broadcast(tonumber(args[1]), tostring(args[2]))
