local Animate = require('animate')

local Mob = class('Mob')


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
    self.an:set_cycle_time(0.75)

    self.dt_cur = 0
    self.speed = 32
end

function Mob:update(dt, world)
    local move_key, move_value = self:_get_move_max()

    if move_value ~= 0 then
        self.an:set_state_cur('walk_' .. move_key)
    else
        self.an:set_state_cur('default')
    end

    if move_key == 'left' then
        --self.pos.x, self.pos.y, cols, len = world:move(self, self.pos.x - (self.speed * dt), self.pos.y)
        --print(self.pos.x)
        self.pos.x = self.pos.x - (self.speed * dt)
    elseif move_key == 'right' then
        self.pos.x = self.pos.x + (self.speed * dt)
    elseif move_key == 'up' then
        self.pos.y = self.pos.y - (self.speed * dt)
    elseif move_key == 'down' then
        self.pos.y = self.pos.y + (self.speed * dt)
    end

    if move_key ~= 'nothing' then
        world:update(self, self.pos.x, self.pos.y)
    end

    self.an:update(dt)
end


function Mob:draw()
    love.graphics.draw(self.sp:get_image(),
                       self.sp:get_quad(unpack(self.an:get_quad_cur())),
                       self.pos.x, self.pos.y)
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

function Mob:get_pos()
    return self.pos.x, self.pos.y
end


return Mob
