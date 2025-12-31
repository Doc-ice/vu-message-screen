-- 
-- 
-- 
return {

  -- EXTERNAL DATA SOURCE
  useExternalSource                   = false,
  --externalSource                      = 'https://plplatoon.com/homebrew/vu-server-1/new.html',
  --externalSource                      = 'https://plplatoon.com/homebrew/vu-server-2/vu-welcome-screen.html',

  -- TABS
  -- IF EXTERNAL SOURCE IS USED, THIS WILL BE REPLACED
  tabs = {
    require('__shared/tabs/tab1.lua'),
    require('__shared/tabs/tab2.lua'),
	require('__shared/tabs/tab3.lua')
  }

}