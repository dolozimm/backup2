local topscreenname = {}
local angle = 0
local myname = 0
local testready = true
local rotation_speed = math.pi / 2 --radians per second
image = love.graphics.newImage("../images/loadingheart.png")

function topscreenname.update(dt)
  angle = angle + rotation_speed * dt
end

function topscreenname.textinput(text)
  myname = text
end

function keyboard()
  if angle == 0 then
    love.keyboard.setTextInput({hint = "Name the fallen human."})
  end
end


function topscreenname.draw(screen)
  love.graphics.setFont(font)
  if screen ~= "bottom" then
    love.graphics.print("Name the fallen human.",93,60)
    love.graphics.draw(image,195,115, angle, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
    if testready then
      keyboard()
      testready = false
    end
  end
  end
return topscreenname