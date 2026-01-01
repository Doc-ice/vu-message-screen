local config = require('__shared/config.lua')
GameModes = {
	ConquestLarge0 = { GameModeName = "ConquestLarge0", DisplayName = "Conquest Large" } ,
	ConquestSmall0 = { GameModeName = "ConquestSmall0", DisplayName = "Conquest Small" } ,
	ConquestAssaultLarge0 = { GameModeName = "ConquestAssaultLarge0", DisplayName = "Assault64" } ,
	ConquestAssaultSmall0 = { GameModeName = "ConquestAssaultSmall0", DisplayName = "Assault" } ,
	ConquestAssaultSmall1 = { GameModeName = "ConquestAssaultSmall1", DisplayName = "Assault #2" } ,
	RushLarge0 = { GameModeName = "RushLarge0", DisplayName = "Rush" } ,
	SquadDeathMatch0 = { GameModeName = "SquadDeathMatch0", DisplayName = "Squad Deathmatch" } ,
	SquadRush0 = { GameModeName = "SquadRush0", DisplayName = "Squad Rush" } ,
	TeamDeathMatch0 = { GameModeName = "TeamDeathMatch0", DisplayName = "TDM" } ,
	TeamDeathMatchC0 = { GameModeName = "TeamDeathMatchC0", DisplayName = "TDM Close Quarters" } ,
	Domination0 = { GameModeName = "Domination0", DisplayName = "Conquest Domination" } ,
	GunMaster0 = { GameModeName = "GunMaster0", DisplayName = "Gun Master" } ,
	Scavenger0 = { GameModeName = "Scavenger0", DisplayName = "Scavenger" } ,
	AirSuperiority0 = { GameModeName = "AirSuperiority0", DisplayName = "Air Superiority" } ,
	TankSuperiority0 = { GameModeName = "TankSuperiority0", DisplayName = "Tank Superiority" } ,
	CaptureTheFlag0 = { GameModeName = "CaptureTheFlag0", DisplayName = "CTF" }
}
Maps = {
	MP_001 = {
		MapName = "MP_001",
		DisplayName = "Grand Bazaar",	
	},

	MP_003 = {
		MapName = "MP_003",
		DisplayName = "Teheran Highway",
	},

	MP_007 = {
		MapName = "MP_007",
		DisplayName = "Caspian Border",
	},

	MP_011 = {
		MapName = "MP_011",
		DisplayName = "Seine Crossing",

	},

	MP_012 = {
		MapName = "MP_012",
		DisplayName = "Operation Firestorm",

	},

	MP_013 = {
		MapName = "MP_013",
		DisplayName = "Damavand Peak",

	},

	MP_017 = {
		MapName = "MP_017",
		DisplayName = "Noshahr Canals",

	},

	MP_018 = {
		MapName = "MP_018",
		DisplayName = "Kharg Island",
	},

	MP_Subway = {
		MapName = "MP_Subway",
		DisplayName = "Operation Metro",
	},

	XP1_001 = {
		MapName = "XP01",
		DisplayName = "Strike at Karkand",
	},

	XP1_002 = {
		MapName = "XP02",
		DisplayName = "Gulf of Oman",
	},

	XP1_003 = {
		MapName = "XP03",
		DisplayName = "Sharqi Peninsula",
	},

	XP1_004 = {
		MapName = "XP04",
		DisplayName = "Wake Island",
	},

	XP2_Factory = {
		MapName = "XP2_Factory",
		DisplayName = "Scrapmetal",
	},

	XP2_Office = {
		MapName = "XP2_Office",
		DisplayName = "Operation 925",
	},

	XP2_Palace = {
		MapName = "XP2_Palace",
		DisplayName = "Donya Fortress",
	},

	XP2_Skybar = {
		MapName = "XP2_Skybar",
		DisplayName = "Ziba Tower",
	},

	XP3_Alborz = {
		MapName = "XP3_Alborz",
		DisplayName = "Alborz Mountains",
	},

	XP3_Desert = {
		MapName = "XP3_Desert",
		DisplayName = "Bandar Desert",
	},

	XP3_Shield = {
		MapName = "XP3_Shield",
		DisplayName = "Armored Shield",
	},

	XP3_Valley = {
		MapName = "XP3_Valley",
		DisplayName = "Death Valley",
	},

	XP4_FD = {
		MapName = "XP4_FD",
		DisplayName = "Markaz Monolith",
	},

	XP4_Parl = {
		MapName = "XP4_Parl",
		DisplayName = "Azadi Palace",
	},

	XP4_Quake = {
		MapName = "XP4_Quake",
		DisplayName = "Epicenter",
	},

	XP4_Rubble = {
		MapName = "XP4_Rubble",
		DisplayName = "Zombie Market",
	},

	XP5_001 = {
		MapName = "XP5_001",
		DisplayName = "Operation Riverside",
	},

	XP5_002 = {
		MapName = "XP5_002",
		DisplayName = "Nebandan Flats",
	},

	XP5_003 = {
		MapName = "XP5_003",
		DisplayName = "Kiasar Railroad",
	},

	XP5_004 = {
		MapName = "XP5_004",
		DisplayName = "Sabalan Pipeline",
	}
}
-- ++++++++++++++++ --
-- VEXT EVENTS      --
-- ++++++++++++++++ --

Events:Subscribe('Level:Loaded', function(levelName, gameMode)
mapname = string.match(levelName, '/(%w+_%w+)')
gm=GameModes[gameMode].DisplayName
ms=Maps[mapname].DisplayName
line={
    title = 'Server Details',
    icon = '🎮',
    content = '<li><p><b>Map </b>'..ms..'</p></li><img src="fb://UI/Art/Menu/LevelThumbs/'..Maps[mapname].MapName..'_thumb" height=150%; width=300%;><p><b>Game Mode </b>'..gm..'</p></li>'
	}
	table.insert(config.tabs, 1,line)
 local configJson = json.encode(config.tabs);
  WebUI:Init()
  WebUI:Show()
  WebUI:BringToFront()
   WebUI:ExecuteJS('createTabs(' .. configJson .. ');')
end)

-- ++++++++++++++++ --
-- WEBUI EVENTS     --
-- ++++++++++++++++ --

Events:Subscribe('WelcomeScreenReady', function(data)

  -- if use of external source, perform request
  if(config.useExternalSource) and (config.externalSource ~= "") then
    local HttpResponse = Net:GetHTTP(config.externalSource)
    if(HttpResponse) and (HttpResponse.body) then
      config.tabs = HttpResponse.body
	  print(config.tabs)
    end
  end

  -- encode to json string
  local configJson = json.encode(config);
  -- execute method in WebUI 
  WebUI:ExecuteJS('createTabs(' .. configJson .. ');')
  

  -- bring ui to front and enable ui-mouse/ disable ui-keyboard
  WebUI:BringToFront()
  WebUI:EnableKeyboard()
  WebUI:EnableMouse()

end)

Events:Subscribe('CloseWelcomeScreen', function(data)
--print('closed')
  -- disable ui input
  -- hide ui
  WebUI:ResetKeyboard();
  WebUI:ResetMouse();
  WebUI:Hide();

  -- unsubscribe from all events
  --Events:Unsubscribe()

end)