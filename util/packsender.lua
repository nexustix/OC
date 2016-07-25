local comp = require("component")
local modem = comp.modem

local args = {...}

modem.broadcast(tonumber(args[1]), string.char(1).."One"..string.char(2).."the cake is a lie"..string.char(4))
