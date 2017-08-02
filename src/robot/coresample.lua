--[[
NOTES

Fill slots 0 to 8 with undesireable items
    (aka items you do not want to mine for)
]]--



local robot = require("robot")
local inventory
local computer = require("computer")

local mode = "cheap"
local runAway = false

if mode == "cheap" then
else
    inventory = require("inventory_controller")
end
--local inventory = require("inventory_controller")


function doRunAway() -- bool; success
    if (not robot.up()) then
        return false
    end
    return true
end


function blockInteresting() -- bool: found
    local foundBlock, blockKind = robot.detect()

    if (not (blockKind == "solid")) then
        return false
    end

    --for i=9, 16 do
    for i=1, 8 do
        --print(i)
        robot.select(i)
        if robot.compare() then
            robot.select(1)
            return false
        end
    end
    robot.select(1)
    return true
end


function mineAllInteresing() -- bool: success
    --print("scanning")
    for i=1, 4 do
        robot.turnRight()
        if blockInteresting() then
            if (not robot.swing()) then
                print("<!> unable to mine interesting block")
                return false
            end
        end

    end
    return true
end


function moveDownward() -- bool: success
    --print("move down")
    local foundBlock, blockKind = robot.detectDown()

    if (blockKind == "solid") then
        if (robot.swingDown()) then
            robot.down()
        else
            print("<!> rock bottom for tool level")
            --runAway = true
            return false
        end
    else
        robot.down()
    end
    return true
end

function fuelPercent() -- number: fuelPercent
    return (computer.energy() / (computer.maxEnergy() / 100))
end

function isFuelLow() -- bool: fuelLow
    if ( fuelPercent() <= 25) then
        return true
    end
    return false
end



while true do

    if runAway then
        if (not doRunAway()) then
            break
        end
    else
        if (isFuelLow()) then
            runAway = true
        end

        if (not moveDownward()) then
            runAway = true
        else
            if (not mineAllInteresing()) then
                runAway = true
            end
        end
    end
end
