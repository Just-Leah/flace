function tick()
    nameplate.ENTITY.setText(rainbow("flace", 5, 10))
end
armor_model.HELMET.setEnabled(false)
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
do
	
CData = 1
PData = 1
action_wheel.SLOT_1.setFunction(function() PData = 1 ping.HatPing(PData) end)
action_wheel.SLOT_1.setTitle("Pineapple Hat")
action_wheel.SLOT_1.setTexture("Custom")
action_wheel.SLOT_1.setTextureScale({0.15,0.15})
action_wheel.SLOT_1.setUV({0, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_2.setFunction(function() PData = 2 ping.HatPing(PData) end)
action_wheel.SLOT_2.setTitle("GNamimates Hat")
action_wheel.SLOT_2.setTexture("Custom")
action_wheel.SLOT_2.setTextureScale({0.15,0.15})
action_wheel.SLOT_2.setUV({64, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_3.setFunction(function() PData = 3 ping.HatPing(PData) end)
action_wheel.SLOT_3.setTitle("KFC Bucket Hat")
action_wheel.SLOT_3.setTexture("Custom")
action_wheel.SLOT_3.setTextureScale({0.15,0.15})
action_wheel.SLOT_3.setUV({16, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_4.setFunction(function() PData = 4 ping.HatPing(PData) end)
action_wheel.SLOT_4.setTitle("Pineapple Hat")
action_wheel.SLOT_4.setTexture("Custom")
action_wheel.SLOT_4.setTextureScale({0.15,0.15})
action_wheel.SLOT_4.setUV({32, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_5.setFunction(function() PData = 5 ping.HatPing(PData) end)
action_wheel.SLOT_5.setTitle("Baker Hat")
action_wheel.SLOT_5.setTexture("Custom")
action_wheel.SLOT_5.setTextureScale({0.15,0.15})
action_wheel.SLOT_5.setUV({48, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_6.setFunction(function() PData = 6 ping.HatPing(PData) end)
action_wheel.SLOT_6.setTitle("Wizard Hat")
action_wheel.SLOT_6.setTexture("Custom")
action_wheel.SLOT_6.setTextureScale({0.15,0.15})
action_wheel.SLOT_6.setUV({96, 112}, {16, 16}, {128, 128})

action_wheel.SLOT_7.setFunction(function() PData = 7 ping.HatPing(PData) end)
action_wheel.SLOT_7.setTitle("Mushroom Hat")
action_wheel.SLOT_7.setTexture("Custom")
action_wheel.SLOT_7.setTextureScale({0.15,0.15})
action_wheel.SLOT_7.setUV({80, 112}, {16, 16}, {128, 128})
end
action_wheel.SLOT_8.setFunction(function()
	PData = 0
	ping.HatPing(PData)
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
function Pineapple()
	HatOff()
		model.Head.Pineapple.setEnabled(true)
		model.Head.Het.setPos{2.5,-5,0}
		model.Head.Het.setRot{0,0,75}
	end
function GNHat()
	HatOff()
		model.Head.GNHat.setEnabled(true)
		model.Head.Het.setPos{2.76,-6,0}
		model.Head.Het.setRot{10,0,0}
	end
function KFC()
	HatOff()
		model.Head.KFC_Bucket.setEnabled(true)
		model.Head.Het.setPos{2,-8,-2}
		model.Head.Het.setRot{0,70,0}
	end
function Crown()
	HatOff()
		model.Head.Crown.setEnabled(true)
		model.Head.Het.setPos{0,0,0}
		model.Head.Het.setRot{0,0,0}
	end
function BakerHat()
	HatOff()
		model.Head.BakerHat.setEnabled(true)
		model.Head.Het.setPos{-2,-7,1}
		model.Head.Het.setRot{10,0,-10}
	end
function WizardHat()
	HatOff()
		model.Head.WizardHat.setEnabled(true)
		model.Head.Het.setPos{-3.8,-5,0}
		model.Head.Het.setRot{10,0,-70}
	end
function MushroomHat()
	HatOff()
		model.Head.MushroomHat.setEnabled(true)
		model.Head.Het.setPos{-2,-2.2,1}
		model.Head.Het.setRot{0,10,-20}
	end
	function HatOff()
		for key, value in pairs(Hats) do
			value.setEnabled(false)
		end
		model.Head.Het.setPos{0,0,0}
		model.Head.Het.setRot{0,0,0}
	end
function ping.HatPing(PData)
	CData = PData
	if CData == 0 then
		HatOff()
	elseif CData == 1 then
		Pineapple()
	elseif CData == 2 then
		GNHat()
	elseif CData == 3 then
		KFC()
	elseif CData == 4 then
		Crown()
	elseif CData == 5 then
		BakerHat()
	elseif CData == 6 then
	WizardHat()
	elseif CData == 7 then
		MushroomHat()
	end
end
timetim = 400
syncthym = 0
function tick()
if syncthym > timetim then
  syncthym = 0
  ping.HatPing(PData)
else
syncthym = syncthym + 1
end
end