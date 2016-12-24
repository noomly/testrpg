local StateGame = class('StateGame')


-- Import local classes
local Level = require('level')
local SpriteSheet = require('spritesheet')
local Mob = require('mob')
local Player = require('player')

-- Define contants
local TILE_SIZE = 64
TILE_SIZE_SP = 16


function StateGame:initialize(level_path)
    self.canvas_game = love.graphics.newCanvas(love.graphics.getDimensions())

    self.canvas_game = love.graphics.newCanvas(love.graphics.getDimensions())
    self.canvas_game:setFilter('nearest', 'nearest', 1)

    self.world = bump.newWorld()

    local lvl_data = require(level_path)
    local tileset_image = love.graphics.newImage(lvl_data.tilesets[1].image)
    local tileset_sp = SpriteSheet:new(tileset_image,
                            love.graphics.newQuad(0, 0,
                            lvl_data.tilesets[1].imagewidth,
                            lvl_data.tilesets[1].imageheight,
                            lvl_data.tilesets[1].imagewidth,
                            lvl_data.tilesets[1].imageheight), 16, 16)
    self.level = Level:new(lvl_data, self.world, tileset_sp)

    local mobs_image = love.graphics.newImage("res/gra/mobs.png")
    local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    local mobs_sp = SpriteSheet:new(mobs_image,
                        love.graphics.newQuad(0, 0, mobs_image_w, mobs_image_h,
                        mobs_image_w, mobs_image_h), 48, 64)

    local player_sp = SpriteSheet:new(mobs_image,
                                      mobs_sp:get_quad(2, 1), TILE_SIZE_SP,
                                      TILE_SIZE_SP)
    self.player = Player:new(player_sp)

    local monster_sp = SpriteSheet:new(mobs_image,
                                       mobs_sp:get_quad(4, 1), TILE_SIZE_SP,
                                       TILE_SIZE_SP)
    self.monster = Mob:new(monster_sp)

    local x, y = self.player:get_pos()
    self.world:add(self.player, x, y, TILE_SIZE_SP, TILE_SIZE_SP)

    local x, y = self.monster:get_pos()
    self.world:add(self.monster, x + 6, y, TILE_SIZE_SP - 12, TILE_SIZE_SP)
end

function StateGame:update(dt)
    self.player:update(dt, self.world)
    self.monster:update(dt, self.world)
end

function StateGame:keypressed(key, scancode, isrepeat)
    self.player:keypressed(key, scancode, isrepeat)
end

function StateGame:keyreleased(key, scancode)
    self.player:keyreleased(key, scancode)
end

function StateGame:draw(dt)
    --love.graphics.scale(TILE_SIZE / TILE_SIZE_SP, TILE_SIZE / TILE_SIZE_SP)

    love.graphics.setCanvas(self.canvas_game)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
        self.level:draw()
        self.player:draw()
        self.monster:draw()
    love.graphics.setCanvas()

    love.graphics.push()
        love.graphics.translate(10, 10)
        love.graphics.setBlendMode('alpha', 'premultiplied')
        love.graphics.scale(TILE_SIZE / TILE_SIZE_SP, TILE_SIZE / TILE_SIZE_SP)
        love.graphics.draw(self.canvas_game, 0, 0)
    love.graphics.pop()
end


return StateGame
