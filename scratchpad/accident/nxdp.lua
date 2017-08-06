package.path = "../../lib/?.lua;" .. package.path
--local nxpacket = require("nxpacket")
local nxpkg = require("nxpacket")

print(nxpkg)

--local tst_pkg = nxpacket.newPackage()
--print(tst_pkg)

local testa = nxpkg.newPackage("the cake is a lie")
print(testa)

for k, v in pairs(nxpkg) do
    print(k)
end

--print(tst_pkg)
