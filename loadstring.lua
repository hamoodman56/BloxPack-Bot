local TextChatService = game:GetService("TextChatService")
local Player = game.Players.LocalPlayer    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Api = "https://games.roblox.com/v1/games/"

local _place,_id = game.PlaceId, game.JobId
-- Asc for lowest player count, Desc for highest player count
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=10"
function ListServers(cursor)
	local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
	return Http:JSONDecode(Raw)
end

time_to_wait = 0 --seconds

function typeChat(str)
	str = tostring(str)
	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		TextChatService.TextChannels.RBXGeneral:SendAsync(str)
	else
		ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(str, "All")
	end
end

wait(5)
local timeElasped = 0
local chat = true
-- typeChat("hi                             System: You can WIN R$ in the best pack opening game! Go to 'bloxpack pages dev' to get started!")

while chat == true do
	typeChat("hi                             System: You can WIN R$ in the best pack opening game! Go to 'bloxpack pages dev' to get started!")
	timeElasped += 1
	if timeElasped >= 16 then
		chat = false
		break
	end
	wait(7.5)
end

while wait(time_to_wait) do
	--freeze player before teleporting to prevent synapse crash?
	Player.Character.HumanoidRootPart.Anchored = true
	local Servers = ListServers()
	local Server = Servers.data[math.random(1,#Servers.data)]
	TPS:TeleportToPlaceInstance(_place, Server.id, Player)
end
