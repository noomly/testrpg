local Mob = require("mob")

local Player = class("Player", Mob)


function Player:initialize(sp)
    Mob.initialize(self, sp)

    self.bb = { x = 6 * TILE_SIZE_O, y = 3 * TILE_SIZE_O, w = TILE_SIZE_O,
        h = TILE_SIZE_O } -- Bounding box

    self.speed = 80
end

function Mob:keypressed(key, scancode, isrepeat)
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

function Mob:keyreleased(key, scancode)
    if key == "left" then
        self.move.left = 0
    elseif key == "right" then
        self.move.right = 0
    elseif key == "up" then
        self.move.up = 0
    elseif key == "down" then
        self.move.down = 0
    end
end


return Player
