local component = require("component")
local event = require("event")
local modem = component.modem

local computer = require("computer")
local srs = require("serialization")

package.path = "../../lib/?.lua;" .. package.path
local nxpkg = require("nxpacket")


print("< - > sending >")
--modem.broadcast(8080, "spam wonderful spam")
local testa = nxpkg.newPackage("the cake is a lie")
local testa_msg = srs.serialize(testa)
modem.broadcast(8080, testa_msg)
