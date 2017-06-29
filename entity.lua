local Animate = require("animate")

local Entity = Object:extend("Entity")

--- Instance a new Entity
-- @param sp SpriteSheet object
-- @param map_object Object from STI
function Entity:new(sp, map_object)
    self.name = "entity"

    self.sp = sp

    self.map_object = map_object

    -- Bounding box
    self.bb = { x = map_object.x, y = map_object.y, w = TILE_SIZE_O,
        h = TILE_SIZE_O }

    self.an = Animate()
end

--- Update
-- @param dt Deltatime
function Entity:update(dt)
    self.an:update(dt)
end

--- Draw
function Entity:draw()
    love.graphics.draw(self.sp:get_image(),
        self.sp:get_quad(unpack(self.an:get_quad_cur())), self:get_pos())
end

--- Get bounding box
-- @return { x, y, w, h }
function Entity:get_bb()
    return { self.bb.x, self.bb.y, self.bb.w, self.bb.h }
end

--- Get position
-- @return x, y
function Entity:get_pos()
    return self.bb.x, self.bb.y
end

--- Get scaled position
-- @return scaled x, y
function Entity:get_spos()
    -- return self.bb.x * (TILE_SIZE / TILE_SIZE_O),
    --          self.bb.y * (TILE_SIZE / TILE_SIZE_O)
    -- return CS.project(self.bb.x * (TILE_SIZE / TILE_SIZE_O),
    --          self.bb.y * (TILE_SIZE / TILE_SIZE_O))
    return CS.project(self.bb.x, self.bb.y)
end

return Entity
