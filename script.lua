function tick()
    nameplate.ENTITY.setText(rainbow("flace", 5, 10))
end

function rainbow(text, speed, offset)
    local function col(x, speed, offset)
        local hue = world.getTime()*speed+x*offset % 360
        return string.format("#%X", vectors.rgbToINT(vectors.hsvToRGB({hue/360, 1, 1})))
    end
    local json = '['
    for i = 1, #text do
        local char = text:sub(i,i)
        json = json .. '{"text": "'..char..'", "color": "' .. col(i, speed, offset) .. '"},'
    end
    json = json:sub(1, #json - 1)
    json = json .. ']'
    return json
end
