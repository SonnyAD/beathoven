local classes = require "utils.classes"

local Page = classes.class()

Page.count = 0


function Page:init(onLoaded, onUnloaded)
    self.id = Page.count
    Page.count = Page.count + 1

    self.onLoaded = onLoaded
    self.onUnloaded = onUnloaded

    self.timeSinceCreated = 0
end

function Page:load()
    if self.onLoaded then
        self:onLoaded()
    end
end

function Page:unload()
    if self.onUnloaded then
        self:onUnloaded()
    end
end

function Page:update(dt)
    self.timeSinceCreated = self.timeSinceCreated + dt
end

function Page:draw()

end

return Page