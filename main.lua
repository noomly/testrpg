-- Import global libs
Object = require("lib/classic")
Inspect = require("lib/inspect")
Util = require("lib/util")
Bump = require("lib/bump")
Sti = require("lib/sti")

-- import local libs
local CScreen = require("lib/cscreen")

-- Import local classes
local StateGame = require("state_game")

-- Define constants
TILE_SIZE_O = 16
TILE_SIZE = 64

-- Define global variables
input = nil

-- Define local variables
local game


function love.load()
    CScreen.init(800, 600, false)

    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    game = StateGame("res/lev/level_1")

    input = require("conf_input")
end

function love.update(dt)
    io.flush()

    if input:released("quit_game") then
        love.event.quit()
    end

    -- print("FPS:", love.timer.getFPS())

    game:update(dt)
end

function love.draw()
    CScreen.apply()

    game:draw()
    --local radius = 20
    --love.graphics.circle("line", love.graphics.getWidth() / 2,
    --    love.graphics.getHeight() / 2, radius)
    --love.graphics.points(love.graphics.getWidth()/2, love.graphics.getHeight()/2)

    CScreen.cease()
end

function love.resize(width, height)
    CScreen.update(width, height)
end

