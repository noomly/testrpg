local Entity = require("entity")

local Mob = Entity:extend()

--- Instance a new Mob
-- @param sp SpriteSheet object
-- @param map_object Object from STI
function Mob:new(sp, map_object)
    Mob.super.new(self, sp, map_object)
    self.name = "mob"

    self.speed = 32

    self.move = { left = 0, right = 0, up = 0, down = 0 }
    self.moving = "standing" -- standing, left, right, up, down
    self.moving_px = 0
    self.move_wait = 0
    self.move_wait_total = 0.083 -- secs

    self.facing = "south"

    self.standing_on = nil -- object

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
end

--- Update
-- @param dt DeltaTime
-- @param world World object
function Mob:update(dt, world)
    Mob.super.update(self, dt)

    local move_key, _ = self:_get_move_max()

    if self.moving == "standing" and move_key ~= "nothing" then
        if self.move_wait < self.move_wait_total then
            if self.move_wait == 0 then
                if move_key == "left" and self.facing == "west" then
                    self.move_wait = self.move_wait_total
                elseif move_key == "right" and self.facing == "east"then
                    self.move_wait = self.move_wait_total
                elseif move_key == "up" and self.facing == "north" then
                    self.move_wait = self.move_wait_total
                elseif move_key == "down" and self.facing == "south" then
                    self.move_wait = self.move_wait_total
                end
            end

            if move_key == "left" then
                self.facing = "west"
            elseif move_key == "right" then
                self.facing = "east"
            elseif move_key == "up" then
                self.facing = "north"
            elseif move_key == "down" then
                self.facing = "south"
            end

            self.move_wait = self.move_wait + dt
        else
            self.move_wait = 0

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
    elseif move_key == "nothing" then
        self.move_wait = 0
    end

    if moving ~= "standing" then
        move_px = self.speed * dt

        if self.moving_px + move_px > TILE_SIZE_O then
            move_px = TILE_SIZE_O - self.moving_px
        end
    end

    local cols, len
    if self.moving == "left" then
        self.bb.x, self.bb.y, cols, len = world:move(self.map_object,
            self.bb.x - move_px, self.bb.y, self.col_filter)
    elseif self.moving == "right" then
        self.bb.x, self.bb.y, cols, len = world:move(self.map_object,
            self.bb.x + move_px, self.bb.y, self.col_filter)
    elseif self.moving == "up" then
        self.bb.x, self.bb.y, cols, len = world:move(self.map_object, self.bb.x,
            self.bb.y - move_px, self.col_filter)
    elseif self.moving == "down" then
        self.bb.x, self.bb.y, cols, len = world:move(self.map_object, self.bb.x,
            self.bb.y + move_px, self.col_filter)
    end

    if len then
        if len > 0 then
            self:collide(cols)
        end
    end

    if self.moving ~= "standing" then
        self.moving_px = self.moving_px + move_px
        if self.moving_px >= TILE_SIZE_O then
            self.moving_px = 0

            if move_key ~= self.moving then
                self.moving = "standing"
            end
        end

        world:update(self.map_object, self.bb.x, self.bb.y)
    end

    if self.moving == "standing" then
        if self.facing == "west" then
            self.an:set_state_cur("stand_left")
        elseif self.facing == "east" then
            self.an:set_state_cur("stand_right")
        elseif self.facing == "north" then
            self.an:set_state_cur("stand_up")
        elseif self.facing == "south" then
            self.an:set_state_cur("stand_down")
        end
    end
end

--- Collide event
-- @param cols Things involved in the event
function Mob:collide(cols)
    -- Doing nothing, extend me in subclasses
end

--- Get the most relevant movement corresponding to pressed the key(s) pressed
--- this is to keep some history on the order the keys have been pressed
-- @return move_key, move_value Movement
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

--- Collision filter
-- @param item
-- @param other Things that got collided with self
-- @return "slide" or nil Collide or not
function Mob.col_filter(item, other)
    if other.type == "door" and other.properties.open then
        return nil
    else
        return "slide"
    end
end

return Mob
