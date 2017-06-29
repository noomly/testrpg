local Mob = require("mob")

local Player = Mob:extend()

--- Instance a new Player
-- @param sp SpriteSheet object
-- @param map_object Object from STI
function Player:new(sp, map_object)
    Player.super.new(self, sp, map_object)
    self.name = "player"

    self.speed = 80

    self.interact = false
end

--- Update
-- @param dt DeltaTime
-- @param world World object
function Player:update(dt, world)
    Player.super.update(self, dt, world)

    self:_manage_input()

    if self.interact then
        self.interact = false
        local items, len

        if self.facing == "west" then
            items, len = world:queryPoint(self.bb.x - 1, self.bb.y + 1)
        elseif self.facing == "east" then
            items, len = world:queryPoint(self.bb.x + 17, self.bb.y + 1)
        elseif self.facing == "north" then
            items, len = world:queryPoint(self.bb.x + 1, self.bb.y - 1)
        elseif self.facing == "south" then
            items, len = world:queryPoint(self.bb.x + 1, self.bb.y + 17)
        end

        if len > 0 then
            for _, object in pairs(items) do
                if object.entity ~= nil then
                    -- print(object.type, len)
                    if object.type == "door" then
                        object.entity:toggle()
                    elseif object.type == "chest" then
                        object.entity:toggle()
                        print("openning chest")
                    end
                end
            end
        end
    end
end

--- Manage input
function Player:_manage_input()
    local _, current_move_value = self:_get_move_max()

    if input:pressed("left") then
        self.move.left = current_move_value + 1
    end
    if input:pressed("right") then
        self.move.right = current_move_value + 1
    end
    if input:pressed("up") then
        self.move.up = current_move_value + 1
    end
    if input:pressed("down") then
        self.move.down = current_move_value + 1
    end

    if input:released("left") then
        self.move.left = 0
    end
    if input:released("right") then
        self.move.right = 0
    end
    if input:released("up") then
        self.move.up = 0
    end
    if input:released("down") then
        self.move.down = 0
    end

    if input:released("interact") then
        self.interact = true
    end
end

--- Collide event
-- @param cols Things involved in the event
function Player:collide(cols)
    if cols[1].other.type == "enemy" then
        print("Ouch! It hurts!")
    elseif cols[1].other.type == "trap" then
        cols[1].other.entity:trigger()
    end
end

-- function Player.col_filter(item, other)
--     if other.name == "door" and other.properties.open then
--         return nil
--     elseif other.name == "chest" then
--         return "slide"
--     else
--         return "slide"
--     end
-- end

return Player
