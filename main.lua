-- Import global libs
class = require('lib/middleclass')
util = require('lib/util')
bump = require('lib/bump')

-- Import local classes
local StateGame = require('state_game')

-- Define local variables
local game


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest', 1)

    game = StateGame:new("res/lev/level_1")
end

function love.update(dt)
    --print("FPS:", love.timer.getFPS())

    game:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    game:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    game:keyreleased(key, scancode)
end

function love.draw(dt)
    game:draw(dt)
end

