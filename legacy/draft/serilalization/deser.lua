
x = load('return {["foo"]="bar"}')()
print(type(x))
print(x)
for k,v in pairs(x) do
    print("k >"..k.."< v >"..v.."<")
end
