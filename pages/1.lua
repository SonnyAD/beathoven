local classes = require "utils.classes"
local Page = require "utils.page"

local Page1 = classes.class(Page)

function Page1:init(onLoaded, onUnloaded)
    self.super:init(onLoaded, onUnloaded)
end

function Page1:load()
    self.super:load()
end

function Page1:unload()
    self.super:unload()
end

function Page1:update(dt)
    self.super:update(dt)
end

function Page1:draw(screenWidth, screenHeight)


end

return Page