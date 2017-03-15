local Animate = require('animate')

local Mob = class('Mob')


function Mob:initialize(sp)
    self.sp = sp

    self.img = { x = 2 * TILE_SIZE_O, y = 3 * TILE_SIZE_O }
    self.bb = {} -- Bounding box
    self:_update_bb()

    self.speed = 32

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
    self.an:set_cycle_time(0.25)
end

function Mob:update(dt, world)
    local move_key, move_value = self:_get_move_max()

    if move_value ~= 0 then
        self.an:set_state_cur('walk_' .. move_key)
    else
        self.an:set_state_cur('default')
    end

    if move_key == 'left' then
        self.bb.x, self.bb.y, cols, len = world:move(self, self.bb.x - (self.speed * dt), self.bb.y)
        --print(self.pos.x)
        --self.pos.x = self.pos.x - (self.speed * dt)
    elseif move_key == 'right' then
        self.bb.x, self.bb.y, cols, len = world:move(self, self.bb.x + (self.speed * dt), self.bb.y)
        --self.pos.x = self.pos.x + (self.speed * dt)
    elseif move_key == 'up' then
        self.bb.x, self.bb.y, cols, len = world:move(self, self.bb.x, self.bb.y - (self.speed * dt))
        --self.pos.y = self.pos.y - (self.speed * dt)
    elseif move_key == 'down' then
        self.bb.x, self.bb.y, cols, len = world:move(self, self.bb.x, self.bb.y + (self.speed * dt))
    end

    if move_key ~= 'nothing' then
        world:update(self, self.bb.x, self.bb.y)
        self:_update_img()
    end

    self.an:update(dt)
end


function Mob:draw()
    love.graphics.draw(self.sp:get_image(),
                       self.sp:get_quad(unpack(self.an:get_quad_cur())),
                       self.img.x, self.img.y)
end

function Mob:_update_img()
    self.img.x = self.bb.x - TILE_SIZE_O / 3
    self.img.y = self.bb.y - (TILE_SIZE_O / 4) / 2
end

function Mob:_update_bb()
    self.bb.x = self.img.x + TILE_SIZE_O / 3
    self.bb.y = self.img.y + (TILE_SIZE_O / 4) / 2
    self.bb.w = TILE_SIZE_O / 3
    self.bb.h = TILE_SIZE_O - TILE_SIZE_O / 4
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

function Mob:get_img()
    return { self.img.x, self.img.y }
end

function Mob:get_bb()
    return { self.bb.x, self.bb.y, self.bb.w, self.bb.h }
end

function Mob:get_simg() -- Get scaled image position
    return { self.img.x * (TILE_SIZE / TILE_SIZE_O),
             self.img.y * (TILE_SIZE / TILE_SIZE_O) }
end


return Mob
