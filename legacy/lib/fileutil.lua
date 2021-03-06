local slz = require 'serialization'

local fileutil = {}

function fileutil.writeln(src, dest)
    dest:write(src)
    dest:write("\n")
end

function fileutil.addValue(val, dest)
    local slzVar = slz.serialize(val)
    fileutil.writeln(slzVar, dest)
end

return fileutil
