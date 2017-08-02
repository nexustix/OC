local component = require("component")
local event = require("event")

local modem = component.modem

local computer = require("computer")


function powerPercent() -- number: fuelPercent
    return (computer.energy() / (computer.maxEnergy() / 100))
end

print(powerPercent())

modem.open(8080)
print("primed")
while true do
    if (powerPercent() >= 50) then
        print("< - > receiving >")
        local _, _, from, port, _, message = event.pull("modem_message")
        print("Got a message from " .. from .. " on port " .. port .. ": " .. tostring(message))
    else
        print("< ! > need more power > sleeping")
        os.sleep(3)
    end
end
