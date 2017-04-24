-- Import global libs
class = require("lib/middleclass")
bump = require("lib/bump")
sti = require("lib/sti")
inspect = require("lib/inspect")
util = require("lib/util")

-- Import local classes
local StateGame = require("state_game")

-- Define constants
TILE_SIZE_O = 16
TILE_SIZE = 64

-- Define local variables
local game


function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    game = StateGame:new("res/lev/level_1")
end

function love.update(dt)
    io.flush()
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
    --local radius = 20
    --love.graphics.circle("line", love.graphics.getWidth() / 2,
    --    love.graphics.getHeight() / 2, radius)
    --love.graphics.points(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
end

