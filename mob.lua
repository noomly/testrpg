local Animate = require('animate')

local Mob = class('Mod')

function Mob:initialize(sp)
    self.sp = sp

    self.pos = { 0, 0 }

    self.an = Animate:new(self.sp:get_image())
    self.an:set_states({
        default = { { 2, 1 } },
        downward = {
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
    self.an:set_state_cur('rotating')
    self.an:set_cycle_time(1)
end

function Mob:update(dt)
    self.an:update(dt)
end

function Mob:draw()
    love.graphics.draw(self.sp:get_image(),
                       self.sp:get_quad(unpack(self.an:get_quad_cur())), 0, 0)
end


return Mob
