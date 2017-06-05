-- Import local classes
local SpriteSheet = require("spritesheet")
local Mob = require("mob")
local Player = require("player")

local StateGame = class("StateGame")

function StateGame:initialize(level_path)
    self.world = bump.newWorld()

    self.map = sti("res/lev/level_1.lua", { "bump" })
    self.map:bump_init(self.world)

    -- local layer_mob = self.map:addCustomLayer("mob", 8)
    -- layer_mob.objects = {}

    local mobs_image = love.graphics.newImage("res/gra/mobs.png")
    local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    local mobs_sp = SpriteSheet:new(mobs_image,love.graphics.newQuad(0, 0,
            mobs_image_w, mobs_image_h, mobs_image_w, mobs_image_h), 64, 64)

    for k, object in pairs(self.map.layers["mob"].objects) do
        local sp = SpriteSheet:new(mobs_image, mobs_sp:get_quad(
            object.properties.imgx, object.properties.imgy), TILE_SIZE_O,
            TILE_SIZE_O)

        if object.name == "player" then
            object.entity = Player:new(sp, object.x, object.y)
        else
            object.entity = Mob:new(sp, object.x, object.y)
        end

        self.world:add(object.entity, unpack(object.entity:get_bb()))
        -- self.world:add(unpack(object.entity:get_bb()))
    end

    for k, object in pairs(self.map.layers.mob.objects) do
        self.map.layers.mob.objects[object.name] = object
    end

    for i=1, (#self.map.layers.mob.objects / 2) + 1, 1 do
        self.map.layers.mob.objects[i] = nil
    end

    self.map.layers.mob.update = function(self, dt, world)
        for k, mob in pairs(self.objects) do
            mob.entity:update(dt, world)
        end
    end

    self.map.layers.mob.draw = function(self)
        for k, mob in pairs(self.objects) do
            mob.entity:draw()
        end
    end


    -- print(inspect(self.map.objects))
    -- print(self.map.objects[61].layer)

    -- local mobs_image = love.graphics.newImage("res/gra/mobs.png")
    -- local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    -- local mobs_sp = SpriteSheet:new(mobs_image,
    --                     love.graphics.newQuad(0, 0, mobs_image_w,
    --                     mobs_image_h, mobs_image_w, mobs_image_h), 64, 64)

    -- local player_sp = SpriteSheet:new(mobs_image,
    --                                   mobs_sp:get_quad(2, 1), TILE_SIZE_O,
    --                                   TILE_SIZE_O)
    -- self.player = Player:new(player_sp)

    -- local monster_sp = SpriteSheet:new(mobs_image,
    --                                    mobs_sp:get_quad(4, 1), TILE_SIZE_O,
    --                                    TILE_SIZE_O)
    -- self.monster = Mob:new(monster_sp)

    -- self.world:add(self.player, unpack(self.player:get_bb()))

    -- self.world:add(self.monster, unpack(self.monster:get_bb()))

    self.camx = 1
    self.camy = 1
    self.lock_camera = false
end

function StateGame:update(dt)
    self.map:update(dt, self.world)

    -- self.player:update(dt, self.world)
    -- self.monster:update(dt, self.world)

    local cam_speed = 200

    local x, y = unpack(self.map.layers.mob.objects.player.entity:get_simg())
    if not self.lock_camera then
        self.camx = x - love.graphics.getWidth() / 2 + TILE_SIZE / 2
        self.camy = y - love.graphics.getHeight() / 2 + TILE_SIZE / 2
    end
end

function StateGame:keypressed(key, scancode, isrepeat)
    self.map.layers.mob.objects.player.entity:keypressed(key, scancode,
        isrepeat)

    if key == "space" then -- TODO: cleanup
        self.lock_camera = not self.lock_camera
    end
end

function StateGame:keyreleased(key, scancode)
    self.map.layers.mob.objects.player.entity:keyreleased(key, scancode)
end

function StateGame:draw(dt)
    love.graphics.push()
        love.graphics.translate(-self.camx, -self.camy)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.scale(TILE_SIZE / TILE_SIZE_O, TILE_SIZE / TILE_SIZE_O)

        self.map:draw()
        --self.map:bump_draw(self.world)

        -- self.player:draw()
        -- self.monster:draw()
    love.graphics.pop()
end


return StateGame
