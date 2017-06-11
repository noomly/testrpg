local Mob = require("mob")

local Player = class("Player", Mob)

function Player:initialize(sp, map_object)
    Mob.initialize(self, sp, map_object)
    self.name = "player"

    self.speed = 80

    self.interact = false
end

function Player:update(dt, world)
    Mob.update(self, dt, world)

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

function Player:keypressed(key, scancode, isrepeat)
    local _, current_move_value = self:_get_move_max()

    if key == "left" then
        self.move.left = current_move_value + 1
    elseif key == "right" then
        self.move.right = current_move_value + 1
    elseif key == "up" then
        self.move.up = current_move_value + 1
    elseif key == "down" then
        self.move.down = current_move_value + 1
    end
end

function Player:keyreleased(key, scancode)
    if key == "left" then
        self.move.left = 0
    elseif key == "right" then
        self.move.right = 0
    elseif key == "up" then
        self.move.up = 0
    elseif key == "down" then
        self.move.down = 0
    end

    if key == "return" then
        self.interact = true
    end
end

function Player:collide(cols)
    -- print(inspect(cols[1]))
    -- print(inspect(cols[1].other))
    if cols[1].other.name == "door" then
        -- print("door!")
        cols[1].other.properties.collidable = false
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
