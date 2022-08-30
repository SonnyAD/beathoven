local mathUtils = require "../utils.math"
local classes = require "../utils.classes"
local Element = require "../responsive.element"

local Node = classes.class(Element)

function Node:init(x, y, size, name)
    self.blinking = false
    self.size = size
    self.name = name
    self.boost = 0
    self.ping = true
    self.blinkingSpeed = 4
    self.stopped = true
    self.blinkingCounter = 0
    self.initialX = x
    self.initialY = y

    self.centerColor = {r=1/255, g=240/255, b=254/255}
    self.super:init(x, y)
end

function Node:pressed(result)
    self.blinking = true
    self.blinkingCounter = 0
    self.stopped = false
    self.ping = true
    self.boost = 1

    if result then
        self.centerColor = {r=10/255, g=254/255, b=25/255}
    else
        self.centerColor = {r=254/255, g=25/255, b=1/255}
    end
end

function Node:testOverlap(x, y)
    return mathUtils.distanceBetween(self.x, self.y, x, y) <= self.size * 0.8 * Element.responsiveScale
end

function Node:update(dt)
    if self.blinkingCounter > 1 then
        self.blinking = false
    end

    if self.stopped == false then 
        self.boost = self.boost + self.blinkingSpeed * (self.ping and dt or -dt)

        if self.boost < 0 or self.boost > 1 then
            self.ping = not self.ping
            self.blinkingCounter = self.blinkingCounter + 1

            if self.boost < 0 then
                self.stopped = true
                self.centerColor = {r=1/255, g=240/255, b=254/255}
            end

            self.boost = self.boost > 1 and 1 or 0
        end
    end

    self.x = Element.screenWidth/2 + (self.initialX * Element.responsiveScale)
    self.y = Element.screenHeight/2 + (self.initialY * Element.responsiveScale)
end

function Node:draw()
    if self.stopped == false then
        love.graphics.setColor(1/255, 240/255, 254/255, 0.02 * self.boost)
        love.graphics.circle("fill", self.x, self.y, self.size * 1 * Element.responsiveScale)

        love.graphics.setColor(1/255, 240/255, 254/255, 0.4 * self.boost)
        love.graphics.circle("fill", self.x, self.y, self.size * 0.5 * Element.responsiveScale)

        love.graphics.setColor(1/255, 240/255, 254/255, 0.7 * self.boost)
        love.graphics.circle("fill", self.x, self.y, self.size * 0.4 * Element.responsiveScale)
    end

    love.graphics.setColor(self.centerColor.r, self.centerColor.g, self.centerColor.b, 1)
    love.graphics.circle("fill", self.x, self.y, self.size * 0.2 * Element.responsiveScale)
end

return Node