local classes = require "../utils.classes"
local Element = require "../responsive.element"

local Packet = classes.class(Element)

function Packet:init(x1, y1, x2, y2, r, g, b, size, failedCallback)
    self.blinking = true
    self.r = r
    self.g = g
    self.b = b
    self.boost = 0
    self.isArrived = true
    self.ping = true
    self.time = 0
    self.x1 = x1
    self.x2 = x2
    self.y1 = y1
    self.y2 = y2
    self.size = size
    self.actualSize = size
    self.blinkingSpeed = 5
    self.targetTime = 10000
    self.failedCallback = failedCallback
    self.super:init(x1, y1)

    self.target = nil

    local img = love.graphics.newImage("assets/star.png")
    self.pSystem = love.graphics.newParticleSystem(img, 32)
    self.pSystem:setParticleLifetime(0.2,0.4)
    self.pSystem:setLinearAcceleration(-100, -1, 100, 100)
    self.pSystem:setSpeed(-50,50)
    self.pSystem:setRotation(10,20)
    self.pSystem:setSpin(20, 50)
    self.emitX = -1
    self.emitY = -1

end

function Packet:setTarget(x2, y2, target)
    self.x2 = x2
    self.y2 = y2
    self.target = target

    self.time = 0
    self.boost = 0
    self.isArrived = false
    self.ping = true
    self.blinking = true
    self.targetTime = 10000
end

function Packet:hasArrived()
    return self.isArrived
end

function Packet:emit()
    self.pSystem:emit(24)
    self.emitX = self.x
    self.emitY = self.y
end

function Packet:arrived(missed)
    if self.isArrived == false then
        self.isArrived = true
        self:emit()
    end
end


function Packet:update(dt)
    self.time = self.time + (dt * 1.45)

    if self.blinking then 
        self.boost = self.boost + self.blinkingSpeed * (self.ping and dt or -dt)
        if self.boost < 0 or self.boost > 1 then
            self.ping = not self.ping
        end
    end

    self.x = Element.screenWidth/2 + (self.x1 + (self.x2 - self.x1) * math.min(self.time, 1)) * Element.responsiveScale
    self.y = Element.screenHeight/2 + (self.y1 + (self.y2 - self.y1) * math.min(self.time, 1)) * Element.responsiveScale

    self.size = self.actualSize * 0.5 + self.actualSize *1.5 * math.min(self.time, 1) * Element.responsiveScale

    if self.time > 1 then 
        self:arrived(true)
    end

    self.pSystem:update(dt)
end

function Packet:draw()
    if self:hasArrived() == false then
        if self.blinking then
            love.graphics.setColor(self.r, self.g, self.b, 0.4 * self.boost)
            love.graphics.circle("fill", self.x, self.y, self.size)

            love.graphics.setColor(self.r, self.g, self.b, 0.7 * self.boost)
            love.graphics.circle("fill", self.x, self.y, self.size * 0.8)
        end

        love.graphics.setColor(self.r, self.g, self.b, 1)
        love.graphics.circle("fill", self.x, self.y, self.size * 0.6)
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.pSystem, self.emitX, self.emitY)
end

return Packet