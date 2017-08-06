local nxmsg = {}

--[[
    BOILERPLATE
]]--
function split(inputstr, sep)
    local t = {} ; i = 1
    if sep == nil then
        sep = "%s"
    end
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
--[[
    BOILERPLATE
]]--


-- create new message
function nxmsg.newMessage()
    local tmp_message = {}
    tmp_message.separator = "<;>"
    tmp_message.segments = {}
    return tmp_message
end

-- add segment to message
function nxmsg.addSegment(the_message, key, kind, data)
    the_message.segments[key] = {}
    the_message.segments[key]["key"] = key
    the_message.segments[key]["kind"] = kind
    the_message.segments[key]["data"] = data

    return the_message
end

-- convert message to string
function nxmsg.toString(the_message)
    local tmp_string = ""

    tmp_string = tmp_string .. the_message.separator .. ":"

    function appendString(the_string)
        tmp_string = tmp_string .. the_string ..the_message.separator
    end

    appendString("")

    for k, v in pairs(the_message.segments) do
        --print(k)
        appendString(v["key"]..":"..v["kind"]..":"..v["data"])
    end

    return tmp_string
end

-- convert string to message
function nxmsg.fromString(the_string)
    local sec_sep = ":"
    local separator = split(the_string, sec_sep)[1]

    local tmp_message = nxmsg.newMessage()

    --addSegment(tmp_message)

    for k, v in pairs(split(the_string, separator)) do
        if k == 1 then
            --HACK skip phantom separator
        else
            local atoms = split(v, sec_sep)
            local header = atoms[1]..sec_sep..atoms[2]..sec_sep
            nxmsg.addSegment(tmp_message, atoms[1],atoms[2], string.sub(v, #header+1))
        end
    end

    --print(separator)

    return tmp_message
end

-- resolve separator data conflicts
function nxmsg.sanitize()
end


----[[ Testing

local test = nxmsg.newMessage()
--print(test)
test = nxmsg.addSegment(test, "elvis_left_building", "bool", "true")
test = nxmsg.addSegment(test, "cake", "str", "lie")
--print(test)

local string_test = nxmsg.toString(test)
print(string_test)

local res_test = nxmsg.fromString(string_test)

local restring_test = nxmsg.toString(res_test)

print(restring_test)
--]]--


--[[ Templates

local msg = {}

msg.separator = "<;>"
msg.segments = {}

msg.segments["name"] = {}
msg.segments["name"]["key"] = "name"
msg.segments["name"]["kind"] = "str"
msg.segments["name"]["data"] = "ben"

-- <;>:<;>name:str:ben<;>id:str:deadbeef<;>msg:str:the cake is a lie<;>

]]--
