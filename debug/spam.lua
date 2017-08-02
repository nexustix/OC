local component = require("component")
local event = require("event")

local modem = component.modem

local computer = require("computer")


function powerPercent() -- number: fuelPercent
    return (computer.energy() / (computer.maxEnergy() / 100))
end

print(powerPercent())



while true do
    if (powerPercent() >= 50) then
        print("< - > sending >")
        modem.broadcast(8080, "spam wonderful spam")

    else
        print("< ! > need more power > sleeping")
        os.sleep(3)
    end
end
