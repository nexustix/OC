local comp = require("component")

--local ee = require("eeprom")

local ee = comp.eeprom

local args = {...}

local file = io.open(args[1])

ee.set(file:read("*a"))
