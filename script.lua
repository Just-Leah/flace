--data api!!!
data.setName("Flace")

-- hide some vanilla stuff --
armor_model.HELMET.setEnabled(false)
vanilla_model.CAPE.setEnabled(false)

-- vector things --

vec = vectors.of
vec0 = vec{0, 0, 0}
vec3 = vec{1, 1, 1}

-- texture size --

texture = vec{128, 128} -- widgth, height

--variables --

time = 0

-- some model stuff --
animation.speeen.start()
animation.speeen.setSpeed(2)
model.Head.Het.setScale({1.4,1.4,1.4})

-- hats --

Hats = {
	model.Head.Pineapple,
    model.Head.GNHat,
	model.Head.KFC_Bucket,
	model.Head.Crown,
	model.Head.BakerHat,
	model.Head.WizardHat,
	model.Head.MushroomHat,
	model.Head.Het,
}

currentHat = tonumber(data.load("hat")) or 0

function setHat(x)
	currentHat = x
	for i, v in pairs(Hats) do
		v.setEnabled(i == x)
	end
end

function switchHat(x)
	data.save("hat", x)
	ping.setHat(x)
end

function ping.setHat(x)
	setHat(x)
end

setHat(currentHat)

-- pings --

a = function(x) print(x) end

pingsRefresh = {
	tickDelay = 50,
	{ping.setHat, _G, "currentHat"},
}

-- action wheel --

if client.isHost() then
	local goToMain = {
		Title = "back",
		Function = function() setWheel("main") end,
		Texture = "Custom",
		UV = {24, 104, 8, 8, texture.x, texture.y},
	}
	action_wheel_folders = {
		pages = {
			page = 0,
			name = "",
			right = {
				setTitle = "next page", 
				setFunction = function() setWheel(action_wheel_folders.pages.name, action_wheel_folders.pages.page+1) end,
				Texture = "Custom",
				setUV = {16, 96, 8, 8, texture.x, texture.y},
			},
			left = {
				setTitle = "previous page", 
				setFunction = function() setWheel(action_wheel_folders.pages.name, action_wheel_folders.pages.page-1) end, 
				Texture = "Custom",
				setUV = {24, 96, 8, 8, texture.x, texture.y},
			},
			first = {
				setTitle = "u are on first page",
				Texture = "Custom",
				setUV = {16, 104, 8, 8, texture.x, texture.y},
			},
			last = {
				setTitle = "u are on last page",
				setFunction = function() end, setHoverColor = {255/255, 80/255, 120/255},
				Texture = "Custom",
				setUV = {16, 104, 8, 8, texture.x, texture.y},
			}
		},
		main = {
			{
				Title = '{"text":"hats","color":"#FF4488"},{"text":"!","color":"#FF88AA"}]',
				Item = "leather_helmet{display:{color:16729258}}",
				Function = function() setWheel("hats") end
			}
		},
		hats = {
			goToMain,
			{
				Title = "Remove Hat",
				Item = "barrier",
				Function = {switchHat, 0},
			},
			{
				Title = "Pineapple Hat",
				Texture = "Custom",
				setUV = {0, 112,  16, 16, texture.x, texture.y},
				Function = {switchHat, 1},
			},
			{
				Title = "GNamimates Hat",
				Texture = "Custom",
				setUV = {64, 112,  16, 16, texture.x, texture.y},
				Function = {switchHat, 2},
			},
			{
				Title = "KFC Bucket Hat",
				Texture = "Custom",
				setUV = {16, 112,  16, 16, texture.x, texture.y},
				Function = {switchHat, 3},
			},
			{
				Title = "Crown",
				Texture = "Custom",
				setUV = {32, 112,  16, 16, texture.x, texture.y},
				Function = {switchHat, 4},
			},
			{
				Title = "Baker Hat",
				Texture = "Custom",
				setUV = {48, 112,  16, 16, texture.x, texture.y},
				Function = {switchHat, 5},
			},
			{
				Title = "Wizard Hat",
				Texture = "Custom",
				setUV = {96, 112,  16, 16, texture.x, texture.y},
				Function = {switchHat, 6},
			},
			{
				Title = "Mushroom Hat",
				Texture = "Custom",
				setUV = {80, 112,  16, 16, texture.x, texture.y},
				Function = {switchHat, 7},
			},
			{
				Title = "Het",
				Item = "stone",
				Function = {switchHat, 8},
			}
		}
	}
	
	function setSlot(x, slot)
		action_wheel["SLOT_"..slot].clear()
		if not x then
			return
		end
		action_wheel["SLOT_"..slot].setFunction(function() end)
		for i, v in pairs(x) do
			if i:sub(1, 3) ~= "set" then
				i = "set"..i
			end
			if i == "setUV" then
				
				action_wheel["SLOT_"..slot].setTextureScale(vec3/texture*16)
				action_wheel["SLOT_"..slot].setUV({v[1], v[2]}, {v[3], v[4]}, {v[5], v[6]})
			elseif i == "setFunction" and type(v) == "table" then
				action_wheel["SLOT_"..slot].setFunction(v[1], v[2])
			else
				action_wheel["SLOT_"..slot][i](v)
			end
		end
	end
	
	function setWheel(wheel_folder, page)
		if page == nil then
			page = 0
		end
		if page < 0 or action_wheel_folders[wheel_folder][1+page*6] == nil then
			return
		end
		action_wheel_folders.pages.name = wheel_folder
		action_wheel_folders.pages.page = page
		wheel_folder = action_wheel_folders[wheel_folder]
		if #wheel_folder > 8 then
			setSlot(action_wheel_folders.pages.right, 4)
			setSlot(action_wheel_folders.pages.left, 5)
			if (page-1) < 0 then
				setSlot(action_wheel_folders.pages.first, 5)
			end
			if wheel_folder[7+page*6] == nil then
				setSlot(action_wheel_folders.pages.last, 4)
			end
			for a = 1, 6 do
				local slot = a+page*6
				a = a-3
				if a > 3 then
					a = a + 2
				end
				a = (a-1)%8+1
				setSlot(wheel_folder[slot], a)
			end
		else
			for i = 1, 8 do
				setSlot(wheel_folder[i], i)
			end
		end
	end
	
	setWheel("main")
end

--   tick   --
function tick()
	--variables--
	time = time + 1
	worldTime = world.getTime()
	local player_name = player.getName()

	--nameplate--
    nameplate.ENTITY.setText(
		rainbow_text("Flace", worldTime, 5, 10, 1):sub(1, -2)..
		',"\n",'..
		rainbow_text(player_name, worldTime + 3, 5, 10, 0.3):sub(2)
	)

	nameplate.ENTITY.setPos{0, currentHat == 0 and 0 or 0.4, 0}

	--pings--
	if time % pingsRefresh.tickDelay == 0 then
		local ping_id = math.floor(time/pingsRefresh.tickDelay) % #pingsRefresh + 1
		local value
		if pingsRefresh[ping_id][2] and pingsRefresh[ping_id][3] then
			value = pingsRefresh[ping_id][2][ pingsRefresh[ping_id][3] ]
		end
		pingsRefresh[ping_id][1](value)
	end
end

function rainbow_text(text, time, speed, offset, saturation)
	--[[
    local function col(x, speed, offset)
        local hue = time*speed+x*offset % 360
        return string.format("#%X", vectors.rgbToINT(vectors.hsvToRGB({hue/360, 1, 1})))
    end--]]
    local json = '['
    for i = 1, #text do
        local char = text:sub(i,i)
		local color = vectors.hsvToRGB{(time * speed + i * offset) / 360, saturation, 1} * 255
        json = json .. '{"text": "'..char..'", "color": "'..string.format("#%02x%02x%02x", color.r, color.g, color.b)..'"},'
    end
    return json:sub(1, -2).."]"
end
--ItsToastCraft was here
--[[
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
		model.Head.Het.setPos{2.76,-5,0}
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
		model.Head.Het.setPos{-3.8,-4.5,0}
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
--]]