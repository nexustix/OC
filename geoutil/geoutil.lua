local geoutil = {}

function geoutil.scan(intensity, x, y)
    local result = geo.scan(x, y)

    for i = 1, intensity do
        local addResult = geo.scan(x, y)
        for k,v in pairs(result) do
            --print(k ..": "..v)
            result[k] = result[k] + addResult[k]
        end
    end

    for k,v in pairs(result) do
        --print(k ..": "..v)
        result[k] = result[k] / (intensity + 1)
    end

    return result
end

function geoutil.scanChunk(intensity, ChunkX, ChunkY)
    for y = 0, 15 do
        for x = 0, 15 do
            print(x.." : "..y)
            self.scan(intensity, x, y)
            --os.sleep(0.1)
        end
    end
end

return geoutil
