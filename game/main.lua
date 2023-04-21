font = love.graphics.newFont("fonts/determination.bcfnt", 25)
fontbig = love.graphics.newFont("fonts/determination.bcfnt",30)
fontsmall = love.graphics.newFont("fonts/small.bcfnt",8)
detersmall = love.graphics.newFont("fonts/determination.bcfnt", 15)
mus_intronoise = love.audio.newSource('music/mus_intronoise.ogg','stream')
splash =love.graphics.newImage("images/intros/splash.png")
local Timers = require "timer"
local intro = require "intro"
local controls = require "controlsintro"
local topscreenname = require "topscreenname"
local firstime = true
local uwu = true
local gotokey = false
local splashmenu = false
local showcontrols = false
local profiler_activated = false
local show = false
local name = ""
local done = false
isinwarningmenu = false
universalTimer = Timers:new() --5.2
splashtimer = Timers:new() --2
function love.load()
   intro.load()
end

function love.textinput(text)
   name = text
end

function love.update(dt)
   intro.update(dt)
   if gotokey then
      topscreenname.update(dt)
      splashtimer:start()
   end
   if universalTimer:check() and universalTimer:check() >= 5.2 then
      show = true
   end
   if splashtimer:check() and splashtimer:check() >=2 and name == "" then
      love.keyboard.setTextInput({hint = "Name the fallen human."})
   end
   if firstime and done then
      showcontrols = true
   end
   state, percent, seconds = love.system.getPowerInfo( )
   if isinwarningmenu then
      mus_story:stop()
      deleteobj(mus_story)
   end
   if splashmenu then
      universalTimer:start()
      if uwu then
         mus_intronoise:setLooping(false)
         mus_intronoise:play()
         uwu = false
      end
   end
end

function love.draw(screen)
   intro.draw(screen)
   if gotokey then
      topscreenname.draw(screen)
   end
   if screen == "bottom" and profiler_activated then
      love.graphics.setFont(detersmall)
      love.graphics.print("BC:".. tostring(isinwarningmenu),65,15)
      love.graphics.print("Name:".. tostring(name),115,15)
      love.graphics.print("RAM: " .. math.floor(collectgarbage("count")) .. " KB / 131072 KB")
      love.graphics.print("Batt: "..percent.."%",0,15)
   end
   if showcontrols and screen ~= "bottom" then
      controls.draw(screen)
   end
   if splashmenu and screen ~= "bottom" then
      love.graphics.draw(splash,40,77)
      if show then
         love.graphics.setFont(fontsmall)
         love.graphics.setColor(128/255, 128/255, 128/255)
         love.graphics.print("[Press A button]", 136,160)
         love.graphics.setColor(1,1,1)
      end
   end
   if isinwarningmenu and screen ~= "bottom" then
      love.graphics.setFont(fontbig)
      love.graphics.print("WARNING!",145,20)
      love.graphics.setFont(detersmall)
      love.graphics.print("This is a unofficial port, so expect a lot of bugs,\ninaccuracies, leak of easter eggs, etc.",40,50)
      love.graphics.print("As a unofficial port, this port has no gains,\nand serve as sole educational and entertainment \npurposes.",40,80)
      love.graphics.print("All rights belong to Toby Fox and his team,\nI am not related with Toby Fox in any way.",40,130)
      love.graphics.print("Please buy the original game before playing this port.",40,180)
      love.graphics.setColor(252/255, 252/255, 4/255)
      love.graphics.print("I Understood.",40,200)
      love.graphics.setColor(1, 1, 1)
   end
end
local button_combination = { 'leftshoulder', 'rightshoulder' }
local button_combination_index = 1

function love.gamepadpressed(joystick, button)
   intro.gamepadpressed(joystick, button)
   if button == "a" and isinwarningmenu then
      isinwarningmenu = false
      if not isinwarningmenu then
         splashmenu = true
      end
   elseif button == "a" and splashmenu then
      splashmenu = false
      done = true
   elseif button == "a" and done then
      showcontrols = false
      done = false
      gotokey = true
   elseif button == "back" then
      love.event.quit()
   end
   if profiler_activated and button == button_combination[1] then
      profiler_activated = false
      return
   end

   if button == button_combination[button_combination_index] then
      button_combination_index = button_combination_index + 1
      if button_combination_index > #button_combination then
         profiler_activated = not profiler_activated
         button_combination_index = 1
      end
   else
      button_combination_index = 1
   end
end