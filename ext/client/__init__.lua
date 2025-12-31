local config = require('__shared/config.lua')
-- ++++++++++++++++ --
-- VEXT EVENTS      --
-- ++++++++++++++++ --

Events:Subscribe('Level:Loaded', function(levelName, gameMode)
mapname = string.match(levelName, '/(%w+_%w+)')
line={
    title = 'Server Info',
    icon = '🥇🥈🏅',
    content = '<h1>server name</h1><b>'..mapname..'<b><h1>Game Mode</h1>'..gameMode
	}
	table.insert(config.tabs, line)
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