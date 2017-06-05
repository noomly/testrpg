local Animate = require("animate")

local Mob = class("Mob")


function Mob:initialize(sp)
    self.name = "mob"

    self.sp = sp

    self.bb = { x = 2 * TILE_SIZE_O, y = 3 * TILE_SIZE_O, w = TILE_SIZE_O,
        h = TILE_SIZE_O } -- Bounding box

    self.speed = 32

    self.move = { left = 0, right = 0, up = 0, down = 0 }
    self.moving = "standing" -- standing, left, right, up, down
    self.moving_old = "standing"
    self.moving_px = 0

    self.an = Animate:new(self.sp:get_image())
    self.an:set_states({
        default = { { 2, 1 } },
        walk_left = {
            { 1, 2 },
            { 3, 2 },
        },
        walk_right = {
            { 1, 3 },
            { 3, 3 },
        },
        walk_up = {
            { 1, 4 },
            { 3, 4 },
        },
        walk_down = {
            { 1, 1 },
            { 3, 1 },
        },
        stand_left = {
            { 2, 2 },
        },
        stand_right = {
            { 2, 3 },
        },
        stand_up = {
            { 2, 4 },
        },
        stand_down = {
            { 2, 1 },
        },
        rotating = {
            { 2, 1 },
            { 2, 3 },
            { 2, 4 },
            { 2, 2 },
        },
    })
    self.an:set_cycle_time(0.50)
end

function Mob:update(dt, world)
    local move_key, move_value = self:_get_move_max()

    if self.moving == "standing" then
        if move_key == "left" then
            self.an:set_state_cur("walk_left")
            self.moving = "left"
        elseif move_key == "right" then
            self.an:set_state_cur("walk_right")
            self.moving = "right"
        elseif move_key == "up" then
            self.an:set_state_cur("walk_up")
            self.moving = "up"
        elseif move_key == "down" then
            self.an:set_state_cur("walk_down")
            self.moving = "down"
        end
    end

    if moving ~= "standing" then
        move_px = self.speed * dt

        if self.moving_px + move_px > TILE_SIZE_O then
            move_px = TILE_SIZE_O - self.moving_px
        end
    end

    local cols, len
    if self.moving == "left" then
        self.bb.x, self.bb.y, cols, len = world:move(self, self.bb.x - move_px, self.bb.y)
    elseif self.moving == "right" then
        self.bb.x, self.bb.y, cols, len = world:move(self, self.bb.x + move_px, self.bb.y)
    elseif self.moving == "up" then
        self.bb.x, self.bb.y, cols, len = world:move(self, self.bb.x, self.bb.y - move_px)
    elseif self.moving == "down" then
        self.bb.x, self.bb.y, cols, len = world:move(self, self.bb.x, self.bb.y + move_px)
    end

    if len then
        if len > 0 then
            -- print(inspect(cols[1].other))
            self:collide(cols)
        end
    end

    if self.moving ~= "standing" then
        self.moving_px = self.moving_px + move_px
        if self.moving_px >= TILE_SIZE_O then
            self.moving_px = 0

            if move_key ~= self.moving then
                self.moving_old = self.moving
                self.moving = "standing"
            end
        end

        world:update(self, self.bb.x, self.bb.y)
    end

    if self.moving == "standing" then
        if self.moving_old == "left" then
            self.an:set_state_cur("stand_left")
        elseif self.moving_old == "right" then
            self.an:set_state_cur("stand_right")
        elseif self.moving_old == "up" then
            self.an:set_state_cur("stand_up")
        elseif self.moving_old == "down" then
            self.an:set_state_cur("stand_down")
        end
    end

    self.an:update(dt)
end

function Mob:collide(cols)
    -- Doing nothing, extend me in subclasses
end

function Mob:draw()
    love.graphics.draw(self.sp:get_image(),
                       self.sp:get_quad(unpack(self.an:get_quad_cur())),
                       self.bb.x, self.bb.y)
end

function Mob:_get_move_max()
    local move_key = 0
    local move_value = -math.huge

    for key, value in pairs(self.move) do
        if move_value < value then
            move_key = key
            move_value = value
        end
    end

    if move_value == 0 then
        move_key = "nothing"
    end

    return move_key, move_value
end

function Mob:get_bb()
    return { self.bb.x, self.bb.y, self.bb.w, self.bb.h }
end

function Mob:get_simg() -- Get scaled image position
    return { self.bb.x * (TILE_SIZE / TILE_SIZE_O),
             self.bb.y * (TILE_SIZE / TILE_SIZE_O) }
end


return Mob
