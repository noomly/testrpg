local StateGame = class('StateGame')


-- Import local classes
local Level = require('level')
local SpriteSheet = require('spritesheet')
local Mob = require('mob')
local Player = require('player')


function StateGame:initialize(level_path)
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

    self.canvas_game = love.graphics.newCanvas(love.graphics.getDimensions())
    self.canvas_game:setFilter('nearest', 'nearest', 1)

    local mobs_image = love.graphics.newImage("res/gra/mobs.png")
    local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    local mobs_sp = SpriteSheet:new(mobs_image,
                        love.graphics.newQuad(0, 0, mobs_image_w,
                        mobs_image_h, mobs_image_w, mobs_image_h), 48, 64)

    local player_sp = SpriteSheet:new(mobs_image,
                                      mobs_sp:get_quad(2, 1), TILE_SIZE_O,
                                      TILE_SIZE_O)
    self.player = Player:new(player_sp)

    local monster_sp = SpriteSheet:new(mobs_image,
                                       mobs_sp:get_quad(4, 1), TILE_SIZE_O,
                                       TILE_SIZE_O)
    self.monster = Mob:new(monster_sp)

    self.world:add(self.player, unpack(self.player:get_bb()))
    --io.read()
    --love.graphics.rectangle('fill', x + TILE_SIZE_O / 3, y, TILE_SIZE_O / 3, TILE_SIZE_O)

    self.world:add(self.monster, unpack(self.monster:get_bb()))

    self.camx = 1
    self.camy = 1
    self.lock_camera = false
end

function StateGame:update(dt)
    self.player:update(dt, self.world)
    self.monster:update(dt, self.world)

    local cam_speed = 200
    --if px > love.graphics.getWidth() - love.graphics.getWidth() / 10 - TILE_SIZE / 2 then
    --    self.camx = self.camx + (cam_speed * dt)
    --elseif px < love.graphics.getWidth() / 10 then
    --    self.camx = self.camx - (cam_speed * dt)
    --elseif py > love.graphics.getHeight() - 100 then
    --    self.camy = self.camy + (cam_speed * dt)
    --elseif py < love.graphics.getHeight() / 10 then
    --    self.camy = self.camy - (cam_speed * dt)
    --end

    local x, y = unpack(self.player:get_simg())
    if not self.lock_camera then
        self.camx = x - love.graphics.getWidth() / 2 + TILE_SIZE / 2
        self.camy = y - love.graphics.getHeight() / 2 + TILE_SIZE / 2
    end
end

function StateGame:keypressed(key, scancode, isrepeat)
    self.player:keypressed(key, scancode, isrepeat)

    if key == 'space' then -- TODO: cleanup
        self.lock_camera = not self.lock_camera
    end
end

function StateGame:keyreleased(key, scancode)
    self.player:keyreleased(key, scancode)
end

function StateGame:draw(dt)
    --love.graphics.setCanvas(self.canvas_game)
    --    love.graphics.clear()
    --    love.graphics.setBlendMode('alpha')
    --    --love.graphics.scale(TILE_SIZE / TILE_SIZE_SP, TILE_SIZE / TILE_SIZE_SP)
    --    self.level:draw()
    --    self.player:draw()
    --    self.monster:draw()
    --love.graphics.setCanvas()

    --love.graphics.push()
    --    love.graphics.translate(-self.camx, -self.camy)
    --    love.graphics.setBlendMode('alpha') -- , 'premultiplied')
    --    love.graphics.scale(2, 2)
    --    love.graphics.draw(self.canvas_game, 0, 0)
    --love.graphics.pop()

    love.graphics.push()
        love.graphics.translate(-self.camx, -self.camy)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
        love.graphics.scale(TILE_SIZE / TILE_SIZE_O, TILE_SIZE / TILE_SIZE_O)
        self.level:draw()
        self.player:draw()
        self.monster:draw()
        --love.graphics.rectangle('fill', self.world:getRect(self.player))
    love.graphics.pop()

    --love.graphics.push()
    --    love.graphics.setBlendMode('alpha') -- , 'premultiplied')
    --    love.graphics.scale(2, 2)
    --    love.graphics.draw(self.canvas_game, 0, 0)
    --love.graphics.pop()
end


return StateGame
