local classes = require "utils.classes"
local Page = require "utils.page"

local Page0 = classes.class(Page)

function Page0:init(onLoaded, onUnloaded)
    self.super:init(onLoaded, onUnloaded)
end

function Page0:load()
    self.super:load()
end

function Page0:unload()
    self.super:unload()
end

function Page0:update(dt)
    self.super:update(dt)
end

function Page0:draw(screenWidth, screenHeight)

    -- todo: font cataglog
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(Fonts.Normal)

    local height = (screenHeight - Fonts.Normal:getHeight("made by") - Fonts.Title:getHeight("Sonny AD") - 20) / 2

    love.graphics.print("made by", (screenWidth - Fonts.Normal:getWidth("made by")) / 2, height)

    love.graphics.setFont(Fonts.Title)
    love.graphics.print("Sonny AD", (screenWidth - Fonts.Title:getWidth("Sonny AD")) / 2, height + 20)

    love.graphics.setColor(0, 0, 0, TransitionAlpha)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
end

return Page