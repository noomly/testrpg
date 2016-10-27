--[[
--]]

TILE_SIZE = 128
TILE_SIZE_SP = 16

FPS = 30

class = require('lib/middleclass')
util = require('lib/util')

local Mob = require('mob')
local SpriteSheet = require('spritesheet')

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    local mobs_image = love.graphics.newImage("res/mobs.png")
    local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    local mobs_sp = SpriteSheet:new("mobs_sp", mobs_image,
                        love.graphics.newQuad(0, 0, mobs_image_w, mobs_image_h,
                        mobs_image_w, mobs_image_h), 48, 64)

    local girl_sp = SpriteSheet:new("girl_sp", mobs_image,
                                    mobs_sp:get_quad(2, 1), TILE_SIZE_SP,
                                    TILE_SIZE_SP)

    bob = Mob:new(girl_sp)
end

function love.update(dt)
    next_time = next_time + 1 / FPS

    bob:update(dt)

    love.timer.sleep(dt - 1 / FPS)
    print(love.timer.getFPS())
end

function love.keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode, isrepeat)
end

function love.draw(dt)
    love.graphics.push()
    love.graphics.scale(TILE_SIZE / TILE_SIZE_SP, TILE_SIZE / TILE_SIZE_SP)

    bob:draw()

    love.graphics.pop()
end
