
banner='https://i.imgur.com/zv33mTZ.jpg'

RCON:SendCommand('vu.ServerBanner', {banner})


Events:Subscribe('Level:Loaded', function(levelName, gameMode, round, roundsPerMap)
ServerGuid = RCON:GetServerGuid()
OnBroadcastServerInfo()
end)
-- Region Broadcast ServerInfo
	-- gets called on OnLevelLoaded
function OnBroadcastServerInfo()
	local args = {}
args['gameMode']=ServerUtils:GetCustomGameModeName()
args['map']=ServerUtils:GetCustomMapName()
args['serverName'] = RCON:SendCommand('vars.serverName')
args['serverDescription'] = RCON:SendCommand('vars.serverDescription')
args['serverMessage'] = RCON:SendCommand('vars.serverMessage')
args['maxPlayers']  = RCON:SendCommand('vars.maxPlayers')
args['gameModeCounter'] 	= RCON:SendCommand('vars.gameModeCounter')
args['ServerBanner']  = RCON:SendCommand('vu.ServerBanner')
args['mapList'] = RCON:SendCommand('mapList.list')
args['MapIndices'] =  RCON:SendCommand('mapList.getMapIndices')
args['Rounds'] = RCON:SendCommand('mapList.getRounds')
args['Frequency'] =  RCON:SendCommand('vu.FrequencyMode')
args['modList'] = RCON:SendCommand('modList.ListRunning')
args['SpectatorCount'] = RCON:SendCommand('vu.SpectatorCount')
serverConfig = args
print(json.encode)
	--NetEvents:Broadcast('ServerInfo', args)
	--local checkURL = "https://plplatoon.com/homebrew/server-list/serverlist.php"
--local res5 = Net:PostHTTP(checkURL,json.encode(serverConfig))
end
-- Endregion