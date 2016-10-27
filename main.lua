-- Import global libs
class = require('lib/middleclass')
util = require('lib/util')

-- Import local libs
local SpriteSheet = require('spritesheet')
local Mob = require('mob')
local Player = require('player')

-- Define contants
local TILE_SIZE = 128
local TILE_SIZE_SP = 16
local MIN_DT = 1/50

-- Define local variables
local next_time
local bob


function love.load()
    next_time = love.timer.getTime()

    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    local mobs_image = love.graphics.newImage("res/mobs.png")
    local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    local mobs_sp = SpriteSheet:new(mobs_image,
                        love.graphics.newQuad(0, 0, mobs_image_w, mobs_image_h,
                        mobs_image_w, mobs_image_h), 48, 64)

    local girl_sp = SpriteSheet:new(mobs_image,
                                    mobs_sp:get_quad(3, 1), TILE_SIZE_SP,
                                    TILE_SIZE_SP)

    bob = Player:new(girl_sp)
end

function love.update(dt)
    next_time = next_time + MIN_DT

    bob:update(dt)
end

function love.keypressed(key, scancode, isrepeat)
    bob:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    bob:keyreleased(key, scancode)
end

function love.draw(dt)
    love.graphics.push()
    love.graphics.scale(TILE_SIZE / TILE_SIZE_SP, TILE_SIZE / TILE_SIZE_SP)

    bob:draw()

    love.graphics.pop()

    local cur_time = love.timer.getTime()
    if next_time <= cur_time then
        next_time = cur_time
        return
    end
    love.timer.sleep(next_time - cur_time)
end
