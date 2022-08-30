Fonts = {}

function Fonts.init()
    Fonts.Normal = love.graphics.newFont("assets/Roboto-Regular.ttf", 18)
    Fonts.Timer = love.graphics.newFont("assets/Roboto-Regular.ttf", 96)
    Fonts.Title = love.graphics.newFont("assets/astro.ttf", 36)
end

return Fonts