local topscreenname = {}
local Timers = require "timer"
local angle = 0
local testready = false
local rotation_speed = math.pi / 2 --radians per second
loadTimer = Timers:new() --2.5
image =love.graphics.newImage("images/intros/loadingheart.png")

function topscreenname.update(dt)
  angle = angle + rotation_speed * dt
end

function topscreenname.draw(screen)
  love.graphics.setFont(font)
  if screen ~= "bottom" then
    love.graphics.print("Name the fallen human.",93,60)
    love.graphics.draw(image,195,115, angle, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
  end
  end
return topscreenname