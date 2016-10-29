-- Import global libs
class = require('lib/middleclass')
util = require('lib/util')

-- Import local libs
local SpriteSheet = require('spritesheet')
local Mob = require('mob')
local Player = require('player')
local Bump = require('lib/bump')

-- Define contants
TILE_SIZE = 64
local TILE_SIZE_SP = 16
local MIN_DT = 1/50

-- Define local variables
local canvas_game
local next_time
local player
local monster
local world


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest', 1)

    canvas_game = love.graphics.newCanvas(love.graphics.getDimensions())
    canvas_game:setFilter('nearest', 'nearest', 1)

    next_time = love.timer.getTime()

    local mobs_image = love.graphics.newImage("res/mobs.png")
    local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    local mobs_sp = SpriteSheet:new(mobs_image,
                        love.graphics.newQuad(0, 0, mobs_image_w, mobs_image_h,
                        mobs_image_w, mobs_image_h), 48, 64)

    local player_sp = SpriteSheet:new(mobs_image,
                                      mobs_sp:get_quad(2, 1), TILE_SIZE_SP,
                                      TILE_SIZE_SP)
    player = Player:new(player_sp)

    local monster_sp = SpriteSheet:new(mobs_image,
                                       mobs_sp:get_quad(4, 1), TILE_SIZE_SP,
                                       TILE_SIZE_SP)
    monster = Mob:new(monster_sp)

    world = Bump.newWorld()

    local x, y = player:get_pos()
    world:add(player, x, y, TILE_SIZE_SP, TILE_SIZE_SP)

    local x, y = monster:get_pos()
    world:add(monster, x, y, TILE_SIZE_SP, TILE_SIZE_SP)
end

function love.update(dt)
    print("FPS:", love.timer.getFPS())

    next_time = next_time + MIN_DT

    player:update(dt, world)
    monster:update(dt, world)
end

function love.keypressed(key, scancode, isrepeat)
    player:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    player:keyreleased(key, scancode)
end

function love.draw(dt)
    --love.graphics.scale(TILE_SIZE / TILE_SIZE_SP, TILE_SIZE / TILE_SIZE_SP)

    love.graphics.setCanvas(canvas_game)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
        player:draw()
        monster:draw()
    love.graphics.setCanvas()

    love.graphics.push()
        love.graphics.setBlendMode('alpha', 'premultiplied')
        love.graphics.scale(TILE_SIZE / TILE_SIZE_SP, TILE_SIZE / TILE_SIZE_SP)
        love.graphics.draw(canvas_game, 0, 0)
    love.graphics.pop()

    local cur_time = love.timer.getTime()
    if next_time <= cur_time then
        next_time = cur_time
        return
    end
    love.timer.sleep(next_time - cur_time)
end
