local Animate = require('animate')

local Mob = class('Mod')


function Mob:initialize(sp)
    self.sp = sp

    self.pos = { x = 0, y = 0 }

    self.move = { left = 0, right = 0, up = 0, down = 0 }

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
        rotating = {
            { 2, 1 },
            { 2, 3 },
            { 2, 4 },
            { 2, 2 },
        },
    })
end

function Mob:update(dt)
    local move_key, move_value = self:_get_move_max()

    if move_value ~= 0 then
        self.an:set_state_cur('walk_' .. move_key)
    else
        self.an:set_state_cur('default')
    end

    self.an:update(dt)
end


function Mob:draw()
    love.graphics.draw(self.sp:get_image(),
                       self.sp:get_quad(unpack(self.an:get_quad_cur())), 0, 0)
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
        move_key = 'nothing'
    end

    return move_key, move_value
end


return Mob
