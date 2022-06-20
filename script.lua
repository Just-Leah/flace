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
	model.Head.EasterBasket,
	model.Head.FryingPan
}

currentHat = tonumber(data.load("hat")) or 0

function setHat(x)
	currentHat = x
	for i, v in pairs(Hats) do
		v.setEnabled(i == x)
	end
end

function ping.switchHat(x)
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
		Title = "Back to Main Page",
		Function = function() setWheel("main") end,
		Texture = "Custom",
		UV = {48, 80, 16, 16, texture.x, texture.y},
	}
	action_wheel_folders = {
		pages = {
			page = 0,
			name = "",
			right = {
				setTitle = "Next", 
				setFunction = function() setWheel(action_wheel_folders.pages.name, action_wheel_folders.pages.page+1) end,
				Texture = "Custom",
				setUV = {32, 80, 16, 16, texture.x, texture.y},
			},
			left = {
				setTitle = "Previous", 
				setFunction = function() setWheel(action_wheel_folders.pages.name, action_wheel_folders.pages.page-1) end, 
				Texture = "Custom",
				setUV = {48, 80, -16, 16, texture.x, texture.y},
			},
			first = {
				setTitle = "You're on the first page",
				Texture = "Custom",
				setUV = {16, 80, 16, 16, texture.x, texture.y},
			},
			last = {
				setTitle = "You're on the last page",
				setFunction = function() end, setHoverColor = {255/255, 80/255, 120/255},
				Texture = "Custom",
				setUV = {16, 80, 16, 16, texture.x, texture.y},
			}
		},
		main = {
			{
				Title = '{"text":"Hats","color":"#FF4488"},{"text":"!","color":"#FF88AA"}]',
				Item = "leather_helmet{display:{color:16729258}}",
				Function = function() setWheel("hats") end
			}
		},
		hats = {
			goToMain,
			{
				Title = '{"text":"Remove Hat","color":"#d43b3b"}',
				Item = "barrier",
				Function = {ping.switchHat, 0},
			},
			{
				Title = '{"text":"Pineapple Hat","color":"#f5b622"}',
				Texture = "Custom",
				setUV = {0, 112,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 1},
			},
			{
				Title = '{"text":"GNamimates Hat","color":"#39b54a"}',
				Texture = "Custom",
				setUV = {64, 112,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 2},
			},
			{
				Title = '{"text":"KFC Bucket Hat","color":"#bb4356"}',
				Texture = "Custom",
				setUV = {16, 112,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 3},
			},
			{
				Title = '{"text":"Crown Hat","color":"#ffeb4e"}',
				Texture = "Custom",
				setUV = {32, 112,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 4},
			},
			{
				Title = '{"text":"Baker Hat","color":"#fef9ed"}',
				Texture = "Custom",
				setUV = {48, 112,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 5},
			},
			{
				Title = '{"text":"Wizard Hat","color":"#222a82"}',
				Texture = "Custom",
				setUV = {96, 112,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 6},
			},
			{
				Title = '{"text":"Mushroom Hat","color":"#ea5c42"}',
				Texture = "Custom",
				setUV = {80, 112,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 7},
			},
			{
				Title = "Het",
				Item = "stone",
				Function = {ping.switchHat, 8},
			},
			{
				Title = '{"text":"Easter Basket Hat","color":"#2fd1c5"}',
				Texture = "Custom",
				setUV = {32, 96,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 9},
			},
			{
				Title = '{"text":"Frying Pan Hat","color":"#292b31"}',
				Texture = "Custom",
				setUV = {48, 96,  16, 16, texture.x, texture.y},
				Function = {ping.switchHat, 10},
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