local Animate = require("animate")

local Entity = Object:extend("Entity")

function Entity:new(sp, map_object)
    self.name = "entity"

    self.sp = sp

    self.map_object = map_object

    -- Bounding box
    self.bb = { x = map_object.x, y = map_object.y, w = TILE_SIZE_O,
        h = TILE_SIZE_O }

    self.an = Animate(self.sp:get_image())
end

function Entity:update(dt)
    self.an:update(dt)
end

function Entity:draw()
    love.graphics.draw(self.sp:get_image(),
        self.sp:get_quad(unpack(self.an:get_quad_cur())), self.bb.x, self.bb.y)
end

function Entity:get_bb()
    return { self.bb.x, self.bb.y, self.bb.w, self.bb.h }
end

return Entity
