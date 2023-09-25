
if host:isHost() then
local Players = 0
local hagglers = 0
local cleck = ""
function onPlayerNotify()
end
function getPlayerList()
return cleck
end
function playPay(fek,you)
if player ~= nil then
if you:getName() == "§r" or you:getName() == "" then
elseif cleck == "" then
cleck = you:getName()..cleck
else
cleck = cleck..",".."   "..you:getName()
end
end
end
function loopy(group)
Players = 0
cleck = ""
	for fek, you in pairs(group) do
	playPay(fek,you)
	if you:isLoaded() then
		Players = Players + 1
	end
	end
	return Players
end
loopy(world:getPlayers())

events.TICK:register(function()
if world.getTime() % 200 == 0 then
if hagglers ~= loopy(world:getPlayers()) then
	onPlayerNotify()
	hagglers = loopy(world:getPlayers())
	host:setActionbar(cleck, false)
	cleck = ""
end
end
end)

function posses()
for fek, you in pairs(world:getPlayers()) do
	log(you:getPos())
end
end
end
