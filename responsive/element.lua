local classes = require "../utils.classes"

local Element = classes.class()

local numElements = 0

Element.targetScreenWidth = 800
Element.targetScreenHeight = 600

function Element.setTargetScreen(width, height)
    Element.targetScreenWidth = width
    Element.targetScreenHeight = height
end

function Element.update()
    Element.screenHeight = love.graphics.getHeight()
    Element.screenWidth = love.graphics.getWidth()

    Element.responsiveScale = Element.screenWidth > Element.screenHeight and Element.screenHeight / Element.targetScreenHeight or Element.screenWidth / Element.targetScreenWidth
end

-- Load initial values at creation of the class
Element.update()

function Element:init(x, y)
    self.x = x
    self.y = y
    self.id = numElements

    self.super:init()

    numElements = numElements + 1
end

return Element