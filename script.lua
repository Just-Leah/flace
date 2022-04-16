function tick()
    nameplate.ENTITY.setText(rainbow("flace", 5, 10))
end

model.Head.Het.setScale({1.4,1.4,1.4})
animation.speeen.start()
animation.speeen.setSpeed(3.142592653589793238462)

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
--ItsToastCraft was here
action_wheel.SLOT_1.setFunction(function() ping.Pineapple() end)
action_wheel.SLOT_1.setTitle("Pineapple Hat")
action_wheel.SLOT_1.setTexture("Custom")
action_wheel.SLOT_1.setTextureScale({0.15,0.15})
action_wheel.SLOT_1.setUV({0, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_2.setFunction(function() ping.GNHat() end)
action_wheel.SLOT_2.setTitle("GNamimates Hat")
action_wheel.SLOT_2.setTexture("Custom")
action_wheel.SLOT_2.setTextureScale({0.15,0.15})
action_wheel.SLOT_2.setUV({64, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_3.setFunction(function() ping.KFC() end)
action_wheel.SLOT_3.setTitle("KFC Bucket Hat")
action_wheel.SLOT_3.setTexture("Custom")
action_wheel.SLOT_3.setTextureScale({0.15,0.15})
action_wheel.SLOT_3.setUV({16, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_4.setFunction(function() ping.Crown() end)
action_wheel.SLOT_4.setTitle("Pineapple Hat")
action_wheel.SLOT_4.setTexture("Custom")
action_wheel.SLOT_4.setTextureScale({0.15,0.15})
action_wheel.SLOT_4.setUV({32, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_5.setFunction(function() ping.BakerHat() end)
action_wheel.SLOT_5.setTitle("Baker Hat")
action_wheel.SLOT_5.setTexture("Custom")
action_wheel.SLOT_5.setTextureScale({0.15,0.15})
action_wheel.SLOT_5.setUV({48, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_6.setFunction(function() ping.WizardHat() end)
action_wheel.SLOT_6.setTitle("Wizard Hat")
action_wheel.SLOT_6.setTexture("Custom")
action_wheel.SLOT_6.setTextureScale({0.15,0.15})
action_wheel.SLOT_6.setUV({96, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_7.setFunction(function() ping.MushroomHat() end)
action_wheel.SLOT_7.setTitle("Mushroom Hat")
action_wheel.SLOT_7.setTexture("Custom")
action_wheel.SLOT_7.setTextureScale({0.15,0.15})
action_wheel.SLOT_7.setUV({80, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_8.setFunction(function()
	for key, value in pairs(Hats) do
		value.setEnabled(false)
		end
	end)
action_wheel.SLOT_8.setItem("minecraft:barrier")
action_wheel.SLOT_8.setTitle("Remove Hat")
Hats = {
    model.Head.GNHat,
	model.Head.Pineapple,
	model.Head.KFC_Bucket,
	model.Head.Crown,
	model.Head.BakerHat,
	model.Head.WizardHat,
	model.Head.MushroomHat
}
for key, value in pairs(Hats) do
	value.setEnabled(false)
end
function ping.Pineapple()
	for key, value in pairs(Hats) do
		value.setEnabled(false)
	end
		model.Head.Pineapple.setEnabled(true)
	end
function ping.GNHat()
	for key, value in pairs(Hats) do
		value.setEnabled(false)
	end
		model.Head.GNHat.setEnabled(true)
	end
function ping.KFC()
	for key, value in pairs(Hats) do
		value.setEnabled(false)
	end
		model.Head.KFC_Bucket.setEnabled(true)
	end
function ping.Crown()
	for key, value in pairs(Hats) do
		value.setEnabled(false)
	end
		model.Head.Crown.setEnabled(true)
	end
function ping.BakerHat()
	for key, value in pairs(Hats) do
		value.setEnabled(false)
	end
		model.Head.BakerHat.setEnabled(true)
	end
function ping.WizardHat()
	for key, value in pairs(Hats) do
		value.setEnabled(false)
	end
		model.Head.WizardHat.setEnabled(true)
	end
function ping.MushroomHat()
	for key, value in pairs(Hats) do
		value.setEnabled(false)
	end
		model.Head.MushroomHat.setEnabled(true)
	end
