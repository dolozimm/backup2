local intro = {}
mus_story = love.audio.newSource('music/mus_story.ogg','stream')
currentintroimage =love.graphics.newImage("images/intros/introimage_0.png")
lastintroimage =love.graphics.newImage("images/intros/introlast.png")
font = love.graphics.newFont("fonts/determination.bcfnt", 25)
fontbig = love.graphics.newFont("fonts/determination.bcfnt",30)
fontsmall = love.graphics.newFont("fonts/small.bcfnt",8)
detersmall = love.graphics.newFont("fonts/determination.bcfnt", 15)
local Timers = require "timer"
local charIndex = 1
local isinintro = true
local dialogIndex = 1
local cu = 1
local charDelay = 0.05
local isinlast = false
local currentci = cu
local dialog = {"Long ago, two races \nruled over Earth: \nHUMANS and MONSTERS.",
"One day, war broke out \nbetween the two races.",
"After a long battle,\nthe humans were\nvictorious.",
"They sealed the \nmonsters underground \nwith a magic spell.",
"Many years later...",
"MT. Ebott \n201X",
"Legends say that those \nwho climb the mountain \nnever return."}
introTimer = Timers:new() --5.4
finalize = Timers:new() --9.1
finale = Timers:new() --3
function loadimg(img)
   if img == 1 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_1.png")
   elseif img == 2 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_2.png")
   elseif img == 3 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_3.png")
   elseif img == 4 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_4.png")
   elseif img == 5 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_5.png")
   elseif img == 6 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_6.png")
   elseif img == 7 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_7.png")
   elseif img == 8 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_8.png")
   elseif img == 9 then
      currentintroimage =love.graphics.newImage("images/intros/introimage_9.png")
   end
end

function deleteobj(object)
   object = nil
   collectgarbage()
end

function intro.load()
   scroll = 260
end

introTimer:start()
love.audio.play(mus_story)
function skipa(cutscene)
   if cutscene == "intro" then
      deleteobj(currentintroimage)
      deleteobj(mus_story)
      isinintro = false
      isinwarningmenu = true
   end
end

function nextDialog()
   if isinintro and not isinlast then
      cu = cu + 1
      dialogIndex = dialogIndex + 1
      charIndex = 1
   end
end

function intro.update(dt)
   if isinintro then
      charDelay = charDelay - dt
      if charDelay < 0 then
         charIndex = charIndex + 1
         charDelay = 0.05
      end
      local elapsedTime = introTimer:check()
      if elapsedTime and elapsedTime >=5.4 and not isinlast then
         nextDialog()
         introTimer:reset()
         introTimer:start()
      end
      if isinlast then
         finale:start()
         if finalize:check() and finalize:check() >= 10 then
            skipa("intro")
         end
      end
      if finale:check() and finale:check() >= 3 and scroll > 0 then
         scroll = scroll - 50 * dt
      end
   end
end

function intro.draw(screen)
   if isinintro then
      local curDialog = dialog[dialogIndex]
      love.graphics.setFont(fontbig)
      if screen ~= "bottom" then
         if cu > currentci then
            loadimg(currentci)
            currentci = currentci + 1
         end
         if currentci == 11 then
            finalize:start()
            isinlast = true
            love.graphics.draw(lastintroimage, 50, -scroll)
         end
         if not isinlast and isinintro then
            love.graphics.draw(currentintroimage,50,42)
         end
         return
      end
      if curDialog then
         love.graphics.print(string.sub(curDialog, 1, charIndex), 45, 65)
      end
   end
end

function intro.gamepadpressed(joystick, button)
   if button == "a" and isinintro then
      skipa("intro")
   end
end
return intro