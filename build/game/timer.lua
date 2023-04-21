local Timer = {}

function Timer:new()
local obj = {}
setmetatable(obj, self)
self.__index = self
obj.startTime = 0
obj.isRunning = false
return obj
end

function Timer:start()
if not self.isRunning then
self.startTime = love.timer.getTime()
self.isRunning = true
end
end

function Timer:check()
if self.isRunning then
return love.timer.getTime() - self.startTime
end
end

function Timer:reset()
self.startTime = 0
self.isRunning = false
end

return Timer