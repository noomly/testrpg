-- Import local classes
local SpriteSheet = require("spritesheet")

local Entity = require("entity")
local Mob = require("mob")
local Player = require("player")

local Door = require("door")
local Trap = require("trap")

local StateGame = Object:extend("StateGame")

--- Instance a new StateGame
-- @param level_path
function StateGame:new(level_name)
    -- self:_load_map(level_name)
    self:_load_map("level_1")

    local x, y, _, _ = self.map.layers.mob.objects.player.entity:get_pos()
    self.camera = Camera()
    self.camera:zoomTo(TILE_SIZE / TILE_SIZE_O)

    self.camx = 1
    self.camy = 1
    self.lock_camera = false
end

--- Update
-- @param dt DeltaTime
function StateGame:update(dt)
    if input:released("toggle_camera") then
        self.lock_camera = not self.lock_camera
    end

    self.map:update(dt, self.world)

    local teleporting = self.map.layers.mob.objects.player.entity:get_teleporting()
    if teleporting then
        print("Teleporting to map " .. teleporting .. "!")
        self:_load_map(teleporting)
    end

    local cam_speed = 200

    local x, y = self.map.layers.mob.objects.player.entity:get_pos()
    x = x + TILE_SIZE_O / 2
    y = y + TILE_SIZE_O / 2

    if not self.lock_camera then
        self.camera:lookAt(x, y)
    end
end

--- Draw
function StateGame:draw()
    self.camera:attach()

    self.map:draw()

    -- self.map:bump_draw(self.world)

    self.camera:detach()
end

--- Resize event
-- @param width
-- @param height
function StateGame:resize(width, height)
    self.map:resize(width, height)
end

--- Load map
-- @param level_path
function StateGame:_load_map(level_name)
    self.world = Bump.newWorld()

    self.map = Sti("res/lev/" .. level_name .. ".lua", { "bump" })
    self.map:bump_init(self.world)

    local mobs_image = love.graphics.newImage("res/gra/mobs.png")
    local mobs_image_w, mobs_image_h = mobs_image:getDimensions()
    local mobs_sp = SpriteSheet(mobs_image,love.graphics.newQuad(0, 0,
            mobs_image_w, mobs_image_h, mobs_image_w, mobs_image_h), 64, 64)

    for k, object in pairs(self.map.layers.mob.objects) do
        local sp = SpriteSheet(mobs_image, mobs_sp:get_quad(
            object.properties.imgx, object.properties.imgy), TILE_SIZE_O,
            TILE_SIZE_O)

        if object.name == "player" then
            object.entity = Player(sp, object)
        else
            object.entity = Mob(sp, object)
        end

        self.world:add(object, unpack(object.entity:get_bb()))
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

    local objects_image = love.graphics.newImage("res/gra/objects.png")
    local objects_image_w, objects_image_h = objects_image:getDimensions()
    local objects_sp = SpriteSheet(objects_image, love.graphics.newQuad(0,
        0, objects_image_w, objects_image_h, objects_image_w, objects_image_h),
        48, 64)

    for k, object in pairs(self.map.layers.interactive.objects) do
        if object.type == "door" then
            local sp = SpriteSheet(objects_image, objects_sp:get_quad(1,
                1), TILE_SIZE_O, TILE_SIZE_O)
            object.entity = Door(sp, object)

        elseif object.type == "chest" then
            local sp = SpriteSheet(objects_image, objects_sp:get_quad(3, 1),
                TILE_SIZE_O, TILE_SIZE_O)
            object.entity = Door(sp, object)

        elseif object.type == "trap" then
            -- local sp = SpriteSheet(objects_image, objects_sp:get_quad(3, 2),
            --     TILE_SIZE_O, TILE_SIZE_O)
            -- object.entity = Trap(sp, object)

        elseif object.type == "teleporter" then
            object.entity = Entity(nil, object)
        end

        if object.entity then
            self.world:add(object, unpack(object.entity:get_bb()))
        end
    end

    self.map.layers.interactive.update = function(self, dt)
        for _, object in pairs(self.objects) do
            if object.entity then
                object.entity:update(dt)
            end
        end
    end

    self.map.layers.interactive.draw = function(self)
        for _, object in pairs(self.objects) do
            if object.entity then
                object.entity:draw()
            end
        end
    end
end

return StateGame
