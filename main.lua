-- Import global libs
Object = require("lib/classic")
Inspect = require("lib/inspect")
Util = require("lib/util")
Bump = require("lib/bump")
Sti = require("lib/sti")
Camera = require("lib/hump/camera")
CS = require("lib/cscreen")

-- import local libs

-- Import local classes
local StateGame = require("state_game")

-- Define constants
TILE_SIZE_O = 16    -- Original tile size
TILE_SIZE = 64      -- Size we want to be rendered

-- Define global variables
input = nil

-- Define local variables
local game


function love.load()
    CS.init(800, 600, true)
    CS.setColor(0, 255, 0)

    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    love.graphics.setBackgroundColor(255, 0, 0)
    -- love.graphics.setBlendMode("alpha")

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
    CS.apply()

    game:draw()

    CS.cease()
end

function love.resize(width, height)
    CS.update(width, height)

    game:resize(width, height)
end

