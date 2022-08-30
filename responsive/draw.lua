local Element = require "responsive.element"

local drawModule = {}

function drawModule.line(x1, y1, x2, y2)
    local screenHeight = love.graphics.getHeight()
    local screenWidth = love.graphics.getWidth()
    local scale = Element.responsiveScale

    love.graphics.line(screenWidth/2 + (x1 * scale), screenHeight/2 + (y1 * scale), screenWidth/2 + (x2 * scale), screenHeight/2 + (y2 * scale))

end

return drawModule