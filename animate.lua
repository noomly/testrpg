local Animate = class('Animate')


function Animate:initialize(image)
    self.image = image

    self.state_cur = 'default'
    self.state_sub = 1
    self.states = { default = { { 1, 1 } } }

    self.cycle_time = 1 -- in second
    self.dt_cur = 0
end

function Animate:update(dt)
    if #self.states[self.state_cur] > 1 then
        self.dt_cur = self.dt_cur + dt

        if self.dt_cur > self.cycle_time / #self.states[self.state_cur]
                         * self.state_sub then
            self.state_sub  = self.state_sub + 1
            if self.state_sub > #self.states[self.state_cur] then
                self.state_sub = 1
            end
        end

        if self.dt_cur > self.cycle_time then
            self.dt_cur = 0
        end
    elseif self.dt_cur > 0 then
        self.dt_cur = 0
    end
end

function Animate:add_state(id, state)
    if type(state) ~= 'table' then
        return
    end

    self.states[id] = state
end

function Animate:set_states(states)
    if type(states) ~= 'table' then
        return
    end

    self.states = states
end

function Animate:set_state_cur(id)
    self.state_cur = id
    self.state_sub = 1
end

function Animate:set_cycle_time(cycle_time)
    self.cycle_time = cycle_time
end

function Animate:get_quad_cur()
    return self.states[self.state_cur][self.state_sub]
end


return Animate
