controlsintro = {}
deter = love.graphics.newFont("fonts/determination.bcfnt", 25)
small = love.graphics.newFont("fonts/small.bcfnt", 8)

function controlsintro.draw(screen)
love.graphics.setFont(deter)
love.graphics.setColor(192/255,192/255,192/255)
love.graphics.print("---Instruction---",100,05)
love.graphics.print("[A Butt.] - Confirm",100,50)
love.graphics.print("[B Butt.] - Cancel",100,75)
love.graphics.print("[Y Butt.] - Menu (In-game)",100,100)
love.graphics.print("[Select] - Quit",100,125)
love.graphics.print("When HP is 0, you lose.",100,150)
love.graphics.setColor(252/255, 252/255, 4/255)
love.graphics.print("Begin Game",100,180)
love.graphics.setFont(small)
love.graphics.setColor(128/255,128/255,128/255)
love.graphics.print("UNDERTALE V1.0 (C) TOBY FOX 2015-2017",73,229)
end
return controlsintro