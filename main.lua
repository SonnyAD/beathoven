local Element = require "responsive.element"

local PartitionManager = require "gameobjects.partitionmanager"

local cron = require 'utils.cron'
local Fonts = require 'fonts'

--local moonshine = require 'moonshine'

local t, shakeDuration, shakeMagnitude = 0, -1, 0
function StartShakeScreen(duration, magnitude)
    t, shakeDuration, shakeMagnitude = 0, duration or 1, magnitude or 5
end

local image1 = love.graphics.newImage("assets/lightDot.png")
image1:setFilter("linear", "linear")

local ps = love.graphics.newParticleSystem(image1, 105)
ps:setColors(1, 1, 1, 0.71484375, 1, 1, 1, 0.75, 0.83203125, 0.83203125, 0.83203125, 0.5)
ps:setDirection(-1.5707963705063)
ps:setEmissionArea("normal", 324.40454101563, 220.49150085449, 0, true)
ps:setEmissionRate(306.06384277344)
ps:setInsertMode("top")
ps:setLinearAcceleration(0, 0, 0, 0)
ps:setLinearDamping(0, 0)
ps:setOffset(90, 90)
ps:setParticleLifetime(0.13734957575798, 0.31618165969849)
ps:setRadialAcceleration(0, 0)
ps:setRelativeRotation(false)
ps:setRotation(5.8195376396179, 0.69473826885223)
ps:setSizeVariation(0)
ps:setSpeed(97.194007873535, 100)
ps:setSpin(0, 0)
ps:setSpinVariation(0)
ps:setSpread(6.2831854820251)
ps:setTangentialAcceleration(0, 0)

function love.load()
    print("Game starting..")

    love.window.setMode(800, 600, {resizable=true, minwidth=400, minheight=300})
    love.window.setTitle("Beathoven")

    --ScreenFX = moonshine(moonshine.effects.chromasep)
                --.chain(moonshine.effects.glow)
                --.chain(moonshine.effects.godsray)
                --.chain(moonshine.effects.fastgaussianblur)
    --ScreenFX.chromasep.angle = 0.5
    --ScreenFX.glow.min_luma = 0.6
    --ScreenFX.glow.strength = 10
    --ScreenFX.godsray.exposure = 0.1
    --ScreenFX.godsray.weight = 0.1
    --ScreenFX.disable("fastgaussianblur")

    BackgroundImage = love.graphics.newImage("assets/background.png")
    TitleImage = love.graphics.newImage("assets/title.png")

    TitleLoop = love.audio.newSource("assets/loop_title.ogg", "static")

    ps:start()

    Page = 0
    DesiredPage = 1

    Score = 0
    
    Cron1 = nil

    Fonts.init()

    PartitionManager.load(IncreaseScore, MissedNote, "s", "e", "f", "c", GameOver)

    HP = 100
    NoteStreak = 0
    LastStreakMessage = 0
    StreakMessages = {}
    StreakMessages[5] = "Ja!"
    StreakMessages[10] = "Elise has your attention!"
    StreakMessages[15] = "Meine liebe Elise!"
    StreakMessages[20] = "She's impressed!"
    StreakMessages[30] = "Her heart is starting beating for you!"
    StreakMessages[40] = "Elise dies ist für dich!"
    StreakMessages[50] = "Elise is in love with you!"

    TimerDuration = 3
    TimerLeft = TimerDuration
    TimerFinished = false
    Timer = nil

    Time = 0
    Time2x = 0
    Time4x = 0

    TransitionAlpha = 1
    FadeIn = false
    FadeOut = true

end

function IncreaseScore()
    Score = Score + 1
    NoteStreak = NoteStreak + 1
    if StreakMessages[NoteStreak] ~= nil then
        LastStreakMessage = NoteStreak
    end
end

function MissedNote()
    --ScreenFX.enable("fastgaussianblur")
    StartShakeScreen(0.2, 0.03)
    HP = HP - 1
    NoteStreak = 0
    LastStreakMessage = 0
    Cron1 = cron.after(0.2, function()
        --ScreenFX.disable("fastgaussianblur")
    end)

    if (HP < 0) then
        GameOver()
    end
end

function GameOver()
    DesiredPage = 3
    FadeIn = true
end

function love.update(dt)
    if Cron1 ~= nil then
        Cron1:update(dt)
    end

    if Timer ~= nil then
        Timer:update(dt)
        TimerLeft = TimerLeft - dt
    end

    Element.update()

    -- Automated transition of the splash
    if Page == 0 and not FadeOut and Cron1 == nil then
        Cron1 = cron.after(1, function()
            FadeIn = true
        end)
    end

    if Page == 1 and DesiredPage == 1 and TitleLoop:isPlaying() == false then
        TitleLoop:play()
    end

    if Page == 2 then
        if TimerFinished and DesiredPage == 2 then
            PartitionManager.update(dt)
        end

        if TitleLoop:isPlaying() then
            TitleLoop:stop()
            Timer = cron.after(TimerDuration, function()
                TimerFinished = true
                Timer = nil
            end)
        end
    end

    Time = Time + dt
    Time2x = Time2x + 2 * dt
    Time4x = Time4x + 4 * dt
    ps:update(dt)

    if t < shakeDuration then
        t = t + dt
    end

    if FadeOut then
        TransitionAlpha = TransitionAlpha - dt * 2
        TitleLoop:setVolume(1 - TransitionAlpha)
        if TransitionAlpha <= 0 then
            TransitionAlpha = 0
            FadeOut = false
        end
    elseif FadeIn then
        TransitionAlpha = TransitionAlpha + dt * 2
        TitleLoop:setVolume(1 - TransitionAlpha)
        if TransitionAlpha >= 1 then
            TransitionAlpha = 1
            FadeIn = false

            if DesiredPage ~= Page then
                Page = DesiredPage
                FadeOut = true
            end
        end
    end

    --ScreenFX.resize(love.graphics.getWidth(), love.graphics.getHeight())
end

function love.keypressed(key, scancode, isrepeat)
    if (key == "escape") then
        love.event.quit(0)
    end

    if (Page == 1 and key == "space") then
       FadeIn = true
       DesiredPage = 2
    end

    if (Page == 3 and key == "r") then
        FadeIn = true
        DesiredPage = 2
    end
end

function love.draw()

    -- common vars
    local screenHeight = love.graphics.getHeight()
    local screenWidth = love.graphics.getWidth()

    if Page == 0 then
        -- background
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(Fonts.Normal)

        ---@diagnostic disable-next-line: redundant-parameter
        local height = (screenHeight - Fonts.Normal:getHeight("made by") - Fonts.Title:getHeight("Sonny AD") - 20) / 2

        love.graphics.print("made by", (screenWidth - Fonts.Normal:getWidth("made by")) / 2, height)

        love.graphics.setFont(Fonts.Title)
        love.graphics.print("Sonny AD", (screenWidth - Fonts.Title:getWidth("Sonny AD")) / 2, height + 20)

        love.graphics.setColor(0, 0, 0, TransitionAlpha)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

    elseif Page == 1 then
        -- background
        love.graphics.setColor(0.1, 0.1, 0.15)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

        love.graphics.setColor(1, 1, 1, 1)
        local scale = screenWidth > screenHeight and screenHeight / TitleImage:getHeight() or screenWidth / TitleImage:getWidth()
        local left = (screenWidth - TitleImage:getWidth() * scale) / 2
        love.graphics.draw(TitleImage, left, (screenHeight - TitleImage:getHeight() * scale) / 2, 0, scale, scale)


        love.graphics.setFont(Fonts.Title)

        love.graphics.setColor(1/255, 120/255, 128/255)
        love.graphics.print("Beathoven", left + 19, 19)
        love.graphics.print("Beathoven", left + 21, 21)
        love.graphics.print("Beathoven", left + 19, 21)
        love.graphics.print("Beathoven", left + 21, 19)

        love.graphics.setColor(254/255, 255/255, 254/255)
        love.graphics.print("Beathoven", left + 20, 20)
        
        love.graphics.setFont(Fonts.Normal)

        love.graphics.setColor(1, 1, 1, 0.3 + 0.7 * (Time2x % 2 < 1 and Time2x % 1 or 1 - Time2x % 1))
        love.graphics.print("Press Space to start", (screenWidth - Fonts.Normal:getWidth("Press Space to start")) / 2 + screenWidth / 4, screenHeight / 2 + 200)

        --love.graphics.push()
        love.graphics.setBlendMode("add")
        love.graphics.draw(ps, 5+0, 4.5+0)
        love.graphics.setBlendMode("alpha")
        --love.graphics.pop()

        love.graphics.setColor(0, 0, 0, TransitionAlpha)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)

    elseif Page == 2 then

        love.graphics.setFont(Fonts.Normal)
        love.graphics.setColor(1, 1, 1, 1)
        
        if t < shakeDuration then
            local dx = love.math.random(-shakeMagnitude, shakeMagnitude)
            local dy = love.math.random(-shakeMagnitude, shakeMagnitude)
            love.graphics.translate(dx, dy)
        end

        --ScreenFX(function()

            local scale = screenWidth > screenHeight and screenHeight / 600 or screenWidth / 800
            love.graphics.draw(BackgroundImage, 0, 0, 0, 1, 1)

            PartitionManager.draw()

            -- foreground debug
            love.graphics.setColor(1, 1, 1)
            if TimerLeft > 0 then 
                love.graphics.setFont(Fonts.Timer)
                local width = Fonts.Timer:getWidth(tostring(math.ceil(TimerLeft)))
                ---@diagnostic disable-next-line: redundant-parameter
                local height = Fonts.Timer:getHeight(tostring(math.ceil(TimerLeft)))
                love.graphics.print(tostring(math.ceil(TimerLeft)), (screenWidth - width) / 2  + width / 2, (screenHeight - height) /2 + height /2, 0, TimerLeft % 1, TimerLeft % 1, width /2, height /2)
                love.graphics.setFont(Fonts.Normal)
            end

            love.graphics.print("Score: "..Score, 20, 20)
            if NoteStreak > 1 then
                local streak = NoteStreak.." notes streak"
                love.graphics.print(streak, screenWidth / 2 - Fonts.Normal:getWidth(streak) / 2, 40)

                -- streak message
                if  NoteStreak - LastStreakMessage < 5 and LastStreakMessage > 0  then
                    love.graphics.print(StreakMessages[LastStreakMessage], screenWidth / 2 - Fonts.Normal:getWidth(StreakMessages[LastStreakMessage]) / 2, 60)
                end
            end
            love.graphics.print("HP: "..HP, screenWidth - 20 - Fonts.Normal:getWidth("HP: "..HP), 20)

            local help = "Controls: S for left, E for up, F for right, and C for down"
            love.graphics.print(help, screenWidth / 2 - Fonts.Normal:getWidth(help) / 2, screenHeight - 30)

            love.graphics.setColor(0, 0, 0, TransitionAlpha)
            love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
        --end)

    elseif Page == 3 then
        
        love.graphics.setFont(Fonts.Normal)
        love.graphics.setColor(1, 1, 1, 1)

        love.graphics.print("Game Over", screenWidth / 2 - Fonts.Normal:getWidth("Game Over") / 2, 40)


        love.graphics.print("Score: "..Score, screenWidth / 2 - Fonts.Normal:getWidth("Score: "..Score) / 2, 200)

        love.graphics.setColor(1, 1, 1, 0.3 + 0.7 * (Time2x % 2 < 1 and Time2x % 1 or 1 - Time2x % 1))
        love.graphics.print("Press R to replay", (screenWidth - Fonts.Normal:getWidth("Press R to replay")) / 2 + screenWidth / 4, screenHeight / 2 + 200)

    end

end



-- 1 / Ticks Per Second
local TICK_RATE = 1 / 60

-- How many Frames are allowed to be skipped at once due to lag (no "spiral of death")
local MAX_FRAME_SKIP = 25

-- No configurable framerate cap currently, either max frames CPU can handle (up to 1000), or vsync'd if conf.lua

function love.run()
    if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
 
    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local lag = 0.0

    -- Main loop time.
    return function()
        -- Process events.
        if love.event then
            love.event.pump()
            for name, a,b,c,d,e,f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return a or 0
                    end
                end
                love.handlers[name](a,b,c,d,e,f)
            end
        end

        -- Cap number of Frames that can be skipped so lag doesn't accumulate
        if love.timer then lag = math.min(lag + love.timer.step(), TICK_RATE * MAX_FRAME_SKIP) end

        while lag >= TICK_RATE do
            if love.update then love.update(TICK_RATE) end
            lag = lag - TICK_RATE
        end

        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())
 
            if love.draw then love.draw() end
            love.graphics.present()
        end

        -- Even though we limit tick rate and not frame rate, we might want to cap framerate at 1000 frame rate as mentioned https://love2d.org/forums/viewtopic.php?f=4&t=76998&p=198629&hilit=love.timer.sleep#p160881
        if love.timer then love.timer.sleep(0.001) end
    end
end