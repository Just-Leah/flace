--imported libraries
local json = require("sjson") --minified Lua json library
require("PlayerNotifier") --does stuff when players change
--data api!!!
config:setName("Flace")
local player_name = avatar:getEntityName()
-- some vanilla stuff --
vanilla_model.HELMET:setVisible(false)
vanilla_model.CAPE:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
-- vector things --
local vec0 = vec(0, 0, 0)
local vec3 = vec(1,1,1)

-- texture size --
local texture = vec(128, 128) -- widgth, height
--					 funny misspelling ^
--variables --
ping = {}
local time = 0
local lhat = 0
local lastHex = ""
-- some model stuff --
local bbmodel = models.model
local hed = bbmodel.Head
local anima = animations.model
anima.speeen:play()
anima.speeen:setSpeed(math.pi)
hed.Het:setScale(1.4,1.4,1.4)

-- hats --
Hats = {
	hed.Pineapple,
	hed.GNHat,
	hed.KFC_Bucket,
	hed.Crown,
	hed.BakerHat,
	hed.WizardHat,
	hed.MushroomHat,
	hed.EasterBasket,
	hed.FryingPan,
	hed.FezPivot
}
local het = hed.Het
local hetPlace = {
	{pos = vec(-2.5,5,0), rot = vec(0,0,75)},
	{pos = vec(2.76,5,0), rot = vec(10,0,0)},
	{pos = vec(-2,8,-2), rot = vec(0,70,0)},
	{pos = vec(0,0,0), rot = vec(0,0,0)},
	{pos = vec(2,7,1), rot = vec(10,0,-10)},
	{pos = vec(3.5,5,0), rot = vec(10,0,-70)},
	{pos = vec(2,2.2,-1), rot = vec(0,10,-20)},
	{pos = vec(0,3,5.5), rot = vec(90,0,-30)},
	{pos = vec(-13,3.7,0), rot = vec(0,0,-10)},
	{pos = vec(3.6,-.7,4), rot = vec(35,0,-35)}--{pos = vec(-1.3,3,3.6), rot = vec(6,0,-74)}
}
hetPlace[0] = {pos = vec(0,0,0), rot = vec(0,0,0)}
local currentHat = config:load("hat") or 0

function setHat(x)
	local x = x or 0
	currentHat = x
	for i, v in pairs(Hats) do
		v:setVisible(i == x)
	end
	het:setPos(hetPlace[x].pos)
	het:setRot(hetPlace[x].rot)
end

function pings.setHat(x)
	config:save("hat", x)
	setHat(x)
end

setHat(currentHat)

-- pings --

a = function(x) print(x) end

pingsRefresh = {
	tickDelay = 50,
	{pings.setHat, _G, "currentHat"},
}

-- action wheel --

if host:isHost() then
	local texture = textures.texture
	local page0 = action_wheel:newPage("main")
local page1 = action_wheel:newPage("hat1")
local page2 = action_wheel:newPage("hat2")
action_wheel:setPage(page0)
page0:newAction(8):setItem("leather_helmet{display:{color:16729258}}"):setTitle("Hats"):setOnLeftClick(function()action_wheel:setPage(page1)end)
page1:newAction(2):setTexture(texture,0,112,16,16):setOnLeftClick(function()pings.setHat(1)end)
:title('{"text":"Pineapple Hat","color":"#f5b622"}')
page1:newAction(3):setTexture(texture,64,112,16,16):setOnLeftClick(function()pings.setHat(2)end)
:title('{"text":"GN: The Hat","color":"#39b54a"}')
page1:newAction(4):setTexture(texture,16,112,16,16):setOnLeftClick(function()pings.setHat(3)end)
:title('{"text":"KFC Bucket Hat","color":"#bb4356"}')
page1:newAction(5):setTexture(texture,32,112,16,16):setOnLeftClick(function()pings.setHat(4)end)
:title('{"text":"Crown","color":"#ffeb4e"}')
page1:newAction(6):setTexture(texture,48,112,16,16):setOnLeftClick(function()pings.setHat(5)end)
:title('{"text":"Baker\'s Hat","color":"#fef9ed"}')
page1:newAction(7):setTexture(texture,96,112,16,16):setOnLeftClick(function()pings.setHat(6)end)
:title('{"text":"Wizard Hat","color":"#222a82"}')
local MenuAction = page1:newAction(8):setTexture(texture,48,80,16,16):setOnLeftClick(function()action_wheel:setPage(page0) end)
:title("Back to Main Page")
page1:newAction(1):setTexture(texture,32,80,16,16):setOnLeftClick(function()action_wheel:setPage(page2) end)
:title("Next")

page2:newAction(2):setTexture(texture,80,112,16,16):setOnLeftClick(function()pings.setHat(7)end)
:title('{"text":"Mushroom Hat","color":"#ea5c42"}')
page2:newAction(3):setTexture(texture,32,96,16,16):setOnLeftClick(function()pings.setHat(8)end)
:title('{"text":"Easter Basket","color":"#2fd1c5"}')
page2:newAction(4):setTexture(texture,48,96,16,16):setOnLeftClick(function()pings.setHat(9)end)
:title('{"text":"Frying Pan","color":"#292b31"}')
local fezAction = page2:newAction(5):setTexture(texture,16,96,16,16):setOnLeftClick(function()pings.setHat(10)end)
:title('{"text":"Fez","color":"#292b31"}')
page2:newAction(6):setItem("minecraft:barrier"):setOnLeftClick(function()pings.setHat(0)end)
:title('{"text":"Remove Hat","color":"#d43b3b"}')
page2:setAction(8,MenuAction)
page2:newAction(1):setTexture(texture,32,80,16,16):setOnLeftClick(function()action_wheel:setPage(page1) end)
:title("Next")
end

--   tick   --
function events.world_tick()
	--variables--
	time = time + 1

	local worldTime = world.getTime()

	--nameplate--
    nameplate.ALL:setText(rainbow_text(player_name, worldTime, 0.275, 2.348568))
    avatar:color(lastHex)
	--nameplate.ENTITY:setText(rainbow_text(player_name, worldTime + 3, 5, 10, 0.3))
	if currentHat == 10 then
		Hats[10].Fez.cube:setColor(lastHex)
	end
	if lhat ~= currentHat then
	nameplate.ENTITY:setPos(0, currentHat == 0 and 0 or 0.4, 0)
	lhat = currentHat
	end
end

local jsonName = {}
function rainbow_text(text, time, speed, offset)
    for i = 1, #text do
		local char = text:sub(i,i)
		if not jsonName[i] then
			jsonName[i] = {}
			jsonName[i].text = char
		end
		local color = vectors.hsvToRGB((time * speed + i * offset) / 240, 1, 1)
		if i == #text then
		lastHex = color
		end
		jsonName[i].color = '#'..vectors.rgbToHex(color)
    end

    return json.encode(jsonName)
end
function onPlayerNotify()
pings.setHat(currentHat)
end
