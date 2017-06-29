local Animate = Object:extend()

--- Instance a new Animate
function Animate:new()
    self.state_cur = "default"
    self.state_sub = 1
    self.states = { default = { { 1, 1 } } }

    self.cycle_time = 0.50 -- in second
    self.dt_cur = 0

    self.play_once = false
end

--- Update
-- @param dt DeltaTime
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

--- Add a state to the Animate object
-- @param id Name of the state
-- @param state A table of table representing the state
function Animate:add_state(id, state)
    if type(state) ~= "table" then
        return
    end

    self.states[id] = state
end

--- Set all the states
-- @param states A table of table of table representing the states
function Animate:set_states(states)
    if type(states) ~= "table" then
        return
    end

    self.states = states
end

--- Set the current state
-- @param id Name of the state
function Animate:set_state_cur(id)
    if self.state_cur ~= id then
        self.state_cur = id
        self.state_sub = 1
    end
end

--- Set the cycle time
-- @param cycle_time Time in second
function Animate:set_cycle_time(cycle_time)
    self.cycle_time = cycle_time
end

--- Get the current quad
-- @return quad
function Animate:get_quad_cur()
    return self.states[self.state_cur][self.state_sub]
end

--- Get the current cycle progress
-- @return number Progress (under 0 and 1)
function Animate:get_state_progress()
    return self.state_sub / #self.states[self.state_cur]
end

return Animate
