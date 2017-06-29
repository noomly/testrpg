local Entity = require("entity")

local Trap = Entity:extend()

--- Instance a new Trap
-- @param sp SpriteSheet object
-- @param map_object Object from STI
function Trap:new(sp, map_object)
    Trap.super.new(self, sp, map_object)
    self.name = "trap"

    self.an:set_cycle_time(0.15)
    self.an:set_states({
        default = { { 1, 1 } },
        calm = {
            { 1, 1 },
        },
        triggered = {
            { 3, 1 },
        },
        triggering = {
            { 1, 1 },
            { 2, 1 },
            { 3, 1 },
        },
        calming = {
            { 3, 1 },
            { 2, 1 },
            { 1, 1 },
        },
    })

    if self.map_object.properties.open then
        self.an:set_state_cur("calm")
    else
        self.an:set_state_cur("closed")
    end
end

--- Update
-- @param dt DeltaTime
function Trap:update(dt)
    Trap.super.update(self, dt)

    if self.an.state_cur == "calming"
        and self.an:get_state_progress() == 1 then
        self.an:set_state_cur("calmed")
    elseif self.an.state_cur == "triggering"
        and self.an:get_state_progress() == 1 then
        self.an:set_state_cur("triggered")
    end
end

--- Trigger the trap
function Trap:trigger()
    if self.map_object.properties.open then
        self.map_object.properties.open = false
        self.an:set_state_cur("triggering")
    else
        self.map_object.properties.open = true
        self.an:set_state_cur("opening")
    end
end

return Trap
