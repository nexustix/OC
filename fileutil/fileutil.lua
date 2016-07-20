local slz = require 'serialization'

local fileutil = {}

function fileutil.writeln(src, dest)
    dest:write(src)
    dest:write("\n")
end

return fileutil
