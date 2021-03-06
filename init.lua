-- Load Extensions
local application = require "hs.application"
local window = require "hs.window"
local hotkey = require "hs.hotkey"
local keycodes = require "hs.keycodes"
local fnutils = require "hs.fnutils"
local alert = require "hs.alert"
local screen = require "hs.screen"
local grid = require "hs.grid"
local hints = require "hs.hints"
local appfinder = require "hs.appfinder"
local applescript = require "hs.applescript"

local tabs = require "tabs"

local definitions = nil
local hyper = nil
local hyper2 = nil


--[[
local function sendLookMouse(command)
  return function()
    local f = io.open("/dev/cu.usbmodem1141211","w")
    if not f then
      return
    end
    f:write(command)
    f:close()
  end
end

local gridset = function(frame)
	return function()
		local win = window.focusedWindow()
		if win then
			grid.set(win, frame, win:screen())
		else
			alert.show("No focused window.")
		end
	end
end

auxWin = nil
function saveFocus()
  auxWin = window.focusedWindow()
  alert.show("Window '" .. auxWin:title() .. "' saved.")
end
function focusSaved()
  if auxWin then
    auxWin:focus()
  end
end

local hotkeys = {}

function createHotkeys()
  for key, fun in pairs(definitions) do
    local mod = hyper
    if string.len(key) == 2 and string.sub(key,2,2) == "c" then
      mod = {"cmd"}
    elseif string.len(key) == 2 and string.sub(key,2,2) == "l" then
      mod = {"ctrl"}
    end

    local hk = hotkey.new(mod, string.sub(key,1,1), fun)
    table.insert(hotkeys, hk)
    hk:enable()
  end
end

function rebindHotkeys()
  for i, hk in ipairs(hotkeys) do
    hk:disable()
  end

  local hk = hotkey.new({}, 'f7', sendLookMouse('.'))
  table.insert(hotkeys, hk)
  hk:enable()

  hotkeys = {}
  createHotkeys()
  alert.show("Rebound Hotkeys")
end

function applyPlace(win, place)
  local scrs = screen:allScreens()
  local scr = scrs[place[1] ]
  grid.set(win, place[2], scr)
end

function applyLayout(layout)
  return function()
    for appName, place in pairs(layout) do
      local app = appfinder.appFromName(appName)
      if app then
        for i, win in ipairs(app:allWindows()) do
          applyPlace(win, place)
        end
      end
    end
  end
end

function init()
  createHotkeys()
  keycodes.inputSourceChanged(rebindHotkeys)
  tabs.enableForApp("Emacs")
  tabs.enableForApp("Atom")
  -- tabs.enableForApp("Sublime Text")

  alert.show("Hammerspoon, at your service.")
end

-- Actual config =================================

hyper = {"cmd", "alt", "ctrl","shift"}
hyper2 = {"ctrl"}
hs.window.animationDuration = 0;
-- hints.style = "vimperator"
-- Set grid size.
grid.GRIDWIDTH  = 6
grid.GRIDHEIGHT = 8
grid.MARGINX = 0
grid.MARGINY = 0
local gw = grid.GRIDWIDTH
local gh = grid.GRIDHEIGHT

local gomiddle = {x = 1, y = 1, w = 4, h = 6}
local goleft = {x = 0, y = 0, w = gw/2, h = gh}
local goright = {x = gw/2, y = 0, w = gw/2, h = gh}
local gobig = {x = 0, y = 0, w = gw, h = gh}

local fullApps = {
  "Safari","Aurora","Nightly","Xcode","Qt Creator","Google Chrome",
  "Google Chrome Canary", "Eclipse", "Coda 2", "iTunes", "Emacs", "Firefox"
}
local layout2 = {
  Airmail = {1, gomiddle},
  Spotify = {1, gomiddle},
  Calendar = {1, gomiddle},
  Dash = {1, gomiddle},
  iTerm = {2, goright},
  MacRanger = {2, goleft},
  ["Path Finder"] = {2, goleft},
  Mail = {2, goright},
}
fnutils.each(fullApps, function(app) layout2[app] = {1, gobig} end)

definitions = {
  [";"] = saveFocus,
  a = focusSaved,

  h = gridset(gomiddle),
  t = gridset(goleft),
  n = grid.maximizeWindow,
  s = gridset(goright),

  g = applyLayout(layout2),

  w = sendLookMouse('.'),

  d = grid.pushWindowNextScreen,
  r = hs.reload,
  q = function() appfinder.appFromName("Hammerspoon"):kill() end,

  k = function() hints.windowHints(appfinder.appFromName("Emacs"):allWindows()) end,
  j = function() hints.windowHints(window.focusedWindow():application():allWindows()) end,
  rl = function() hyper, hyper2 = hyper2,hyper; rebindHotkeys() end,
  ec = function() hints.windowHints(nil) end
}

-- launch and focus applications
fnutils.each({
  { key = "o", app = "Path Finder" },
  { key = "e", app = "Google Chrome" },
  { key = "u", app = "Sublime Text" },
  { key = "i", app = "iTerm2" },
  { key = "x", app = "Xcode" },
  { key = "m", app = "Mail" }
}, function(object)
    definitions[object.key] = function()
      local app = appfinder.appFromName(object.app)
      if app then app:activate() end
    end
end)

for i=1,6 do
  definitions[tostring(i)] = function()
    local app = application.frontmostApplication()
    tabs.focusTab(app,i)
  end
end

init()
--]]


--Anoop:
--using: learning: http://www.hammerspoon.org/go/

--auto reload config when .lua files change:
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
--hs.alert.show("Config auto-loaded")

--left, right, center move app
hs.hotkey.bind({}, "F6", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2.2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind({}, "F8", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2.2)
  f.y = max.y
  f.w = max.w / 1.83
  f.h = max.h
  win:setFrame(f)
end)

--center
hotkey.bind({}, "F7", function()
  local win = window.focusedWindow()
  if not win then
    alertCannotManipulateWindow()
    return
  end
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  if max.x < 0 then
    -- If on screen on the left of the main display
    f.x = max.x + f.w / 2
  else
    f.x = (max.w - f.w) / 2
  end
  f.y = (max.h - f.h) / 2
  f.w = max.w / 1.5
  win:setFrame(f)
end)




--simple app switching & integrated resizing

hs.hotkey.bind({"CTRL"}, "U", function()
  hs.window.animationDuration=0
--  hs.application.launchOrFocus("Google Chrome Canary")
--  hs.application.launchOrFocus("Preview")
  --hs.application.launchOrFocus("Safari")
--  hs.application.launchOrFocus("iTerm")
  hs.application.launchOrFocus("Google Chrome")
 -- hs.application.launchOrFocus("Sublime Text 2")
--[[hs.application.open("mpv", 5, true)

  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  --f.y = max.y
--edited to center vlc on y axis
f.y = max.y * 11
 f.w = max.w / 2.2
  --f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)  
]]--

end)

--temp start

hs.hotkey.bind({}, "F13", function()
  hs.window.animationDuration=0
  hs.application.launchOrFocus("iTerm")
  --[[
  hs.application.open("iTerm", 5, true)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2.2)
  f.y = max.y
  f.w = max.w / 1.83
  f.h = max.h
  win:setFrame(f)
  ]]--

end)


--simple app switching & integrated resizing

hs.hotkey.bind({"CTRL"}, ";", function()
  hs.window.animationDuration=0
--  hs.application.launchOrFocus("Google Chrome Canary")
  hs.application.launchOrFocus("Google Chrome")
  --[[
  hs.application.open("iTerm", 5, true)

  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
--edited to center vlc on y axis
-- f.y = max.y * 11
 f.w = max.w / 2.2
  --f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)  
  ]]--
  
end)
--temp ends

hs.hotkey.bind({"CTRL"}, "I", function()
  hs.window.animationDuration=0
  --hs.application.launchOrFocus("Sublime Text")
-- hs.application.launchOrFocus("Emacs")

  hs.application.open("Emacs", 5, true)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2.2)
  f.y = max.y
  f.w = max.w / 1.83
  f.h = max.h
  win:setFrame(f)

end)

--[[
hs.hotkey.bind({"CTRL"}, ";", function()
  hs.window.animationDuration=0
--  hs.application.open("Google Chrome", 5, true)
  
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2.2)
  --f.x = max.x + (max.w / 1.83)
  f.y = max.y
  f.w = max.w / 1.83
  --f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
  
end)
--]]


hs.hotkey.bind({}, "F1", function()
  --hs.window.animationDuration=0
--  hs.application.launchOrFocus("Sublime Text 2")
  hs.application.launchOrFocus("Finder")
--[[  hs.application.open("Google Chrome", 5, true)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2.2
  f.h = max.h
  win:setFrame(f)  
  ]]--
end)


hs.hotkey.bind({}, "F2", function()
  hs.window.animationDuration=0
  --hs.application.launchOrFocus("Sublime Text")
  hs.application.open("Finder", 5, true)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2.2
  f.h = max.h
  win:setFrame(f)  
end)


--[[
hs.hotkey.bind({}, "F9", function()
  hs.window.animationDuration=0
--  hs.application.launchOrFocus("Emacs")
  hs.application.open("Sublime Text", 9, true)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2.2)
  f.y = max.y
  f.w = max.w / 1.83
  f.h = max.h
  win:setFrame(f)
end)
]]--
   
hs.hotkey.bind({}, "F5", function()
  hs.window.animationDuration=0
  hs.application.launchOrFocus("iterm")
--[[  hs.application.open("Sublime Text", 9, true)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2.2)
  f.y = max.y
  f.w = max.w / 1.83
  f.h = max.h
  win:setFrame(f)
]]--
end)

--set Esc to quit windows
--I have done this in Karabiner private.xml


