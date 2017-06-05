local StateGame = class("StateGame")


-- Import local classes
local SpriteSheet = require("spritesheet")
local Mob = require("mob")
local Player = require("player")

function StateGame:initialize(level_path)
    self.world = bump.newWorld()

    self.map = sti("res/lev/level_1.lua", { "bump" })
    self.map:bump_init(self.world)

    local mobs_image = love.graphics.newImage("res/gra/mobs.png")
    local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    local mobs_sp = SpriteSheet:new(mobs_image,
                        love.graphics.newQuad(0, 0, mobs_image_w,
                        mobs_image_h, mobs_image_w, mobs_image_h), 64, 64)

    local player_sp = SpriteSheet:new(mobs_image,
                                      mobs_sp:get_quad(2, 1), TILE_SIZE_O,
                                      TILE_SIZE_O)
    self.player = Player:new(player_sp)

    local monster_sp = SpriteSheet:new(mobs_image,
                                       mobs_sp:get_quad(4, 1), TILE_SIZE_O,
                                       TILE_SIZE_O)
    self.monster = Mob:new(monster_sp)

    self.world:add(self.player, unpack(self.player:get_bb()))

    self.world:add(self.monster, unpack(self.monster:get_bb()))

    self.camx = 1
    self.camy = 1
    self.lock_camera = false
end

function StateGame:update(dt)
    self.map:update()

    self.player:update(dt, self.world)
    self.monster:update(dt, self.world)

    local cam_speed = 200

    local x, y = unpack(self.player:get_simg())
    if not self.lock_camera then
        self.camx = x - love.graphics.getWidth() / 2 + TILE_SIZE / 2
        self.camy = y - love.graphics.getHeight() / 2 + TILE_SIZE / 2
    end
end

function StateGame:keypressed(key, scancode, isrepeat)
    self.player:keypressed(key, scancode, isrepeat)

    if key == "space" then -- TODO: cleanup
        self.lock_camera = not self.lock_camera
    end
end

function StateGame:keyreleased(key, scancode)
    self.player:keyreleased(key, scancode)
end

function StateGame:draw(dt)
    love.graphics.push()
        love.graphics.translate(-self.camx, -self.camy)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.scale(TILE_SIZE / TILE_SIZE_O, TILE_SIZE / TILE_SIZE_O)

        self.map:draw()
        --self.map:bump_draw(self.world)

        self.player:draw()
        self.monster:draw()
    love.graphics.pop()
end


return StateGame
