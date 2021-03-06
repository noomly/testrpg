local Entity = require("entity")

local Door = Entity:extend()

--- Instance a new Door
-- @param sp SpriteSheet object
-- @param map_object Object from STI
function Door:new(sp, map_object)
    Door.super.new(self, sp, map_object)
    self.name = "door"

    self.an:set_cycle_time(0.15)
    self.an:set_states({
        default = { { 1, 4 } },
        closed = {
            { 1, 1 },
        },
        opened = {
            { 1, 4 },
        },
        closing = {
            { 1, 4 },
            { 1, 3 },
            { 1, 2 },
            { 1, 1 },
        },
        opening = {
            { 1, 1 },
            { 1, 2 },
            { 1, 3 },
            { 1, 4 },
        },
    })

    if self.map_object.properties.open then
        self.an:set_state_cur("opened")
    else
        self.an:set_state_cur("closed")
    end
end

--- Update
-- @param dt DeltaTime
function Door:update(dt)
    Door.super.update(self, dt)

    if self.an.state_cur == "closing"
        and self.an:get_state_progress() == 1 then
        self.an:set_state_cur("closed")
    elseif self.an.state_cur == "opening"
        and self.an:get_state_progress() == 1 then
        self.an:set_state_cur("opened")
    end
end

--- Open or close the door depending on its current state
function Door:toggle()
    if self.map_object.properties.open then
        self.map_object.properties.open = false
        self.an:set_state_cur("closing")
    else
        self.map_object.properties.open = true
        self.an:set_state_cur("opening")
    end
end

return Door
