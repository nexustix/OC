local os = require("os")
local term = require("term")
local event = require("event")

local component = require("component")
local sides = require("sides")
local trp = component.transposer
local gpu = component.gpu
local screen = component.screen

local side_money = sides.north
local side_bank  = sides.south
local side_good1 = sides.east
local side_good2 = sides.west

local name_money = "minecraft:diamond"
local name_money_block = ""
local name_good1 = ""
local name_good2 = ""


term.clear()

local slot = 1
--local item = component.transposer.getStackInInternalSlot(slot)

local button_data = {}

function addButton(index, header, body, footer, action)
    button_data[index] = {}
    button_data[index].header = header
    button_data[index].body = body
    button_data[index].footer = footer
    button_data[index].action = action

    button_data[index].hover = false
end

function getItemCountInSide(itemName, side)
    local c = 0
    for i=1, trp.getInventorySize(side) do
        local tmp_item = trp.getStackInSlot(side, i)

        if not (tmp_item == nil) and (tmp_item.name == itemName) then
            c = c + tmp_item.size
        end
    end
    return math.floor(c)
end

function setupScreen()
    local w, h = 20,17
    --gpu.setResolution(w,h)
    gpu.setResolution(20,17)
    gpu.fill(1, 1, w, h, " ")
    screen.setTouchModeInverted(true)
end

function drawRect(color, xPos,yPos,width,height)
    local old_color = gpu.getBackground()
    gpu.setBackground(color)

    for x=xPos,xPos+width do
        for y=yPos,yPos+height do
            gpu.set(x,y,' ')
        end
    end

    gpu.setBackground(old_color)
end

function qDrawButton(index, header, body, footer)
    local old_color = gpu.getBackground()

    local y_pos = ((index*3)+index)-1
    if button_data[index] then
        if button_data[index].hover then
            drawRect(0xB0B000, 2, y_pos, 17, 2)
        else
            drawRect(0x00B000, 2, y_pos, 17, 2)
        end
    else
        return false
    end
    --gpu.setBackground(0x808000)
    gpu.setBackground(0x00B000)
    if button_data[index].header then
        gpu.set(3, y_pos, tostring(button_data[index].header))
    end
    if button_data[index].body then
        gpu.set(3, y_pos+1, tostring(button_data[index].body))
    end

    if button_data[index].footer then
        gpu.set(3, y_pos+2, tostring(button_data[index].footer))
    end

    gpu.setBackground(old_color)
    return true
end

function posToButton()
end
--[[
gpu.setBackground(0x00B6FF)
setupScreen()
--print("the cake is a lie")
gpu.set(1,1, "Vending 3000")

addButton(1, "header", "body", "footer")

print(qDrawButton(1, "xheader", "xbody", "xfooter"))

]]--
--setupScreen()
--addButton(1, "-header", "-body", "-footer")
--qDrawButton(1)

_, _, xPos, yPos, buttonIndex, buttonKind = event.pull("touch")

--[[
local stuff = trp.getStackInSlot(sides.south, slot)


for k,v in pairs(stuff) do
    print(tostring(k)..":"..tostring(v))
end

print(trp.getInventorySize(side_money))

while true do
    os.sleep()
end
]]--

--[[
if item then
	print("Item name: ", item.name)
	print("Item count: ", item.size)
	print("Item damage: ", item.damage)
else
	print("Slot " .. slot .. " is empty")
end
]]--
