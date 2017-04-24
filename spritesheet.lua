local SpriteSheet = class("SpriteSheet")


function SpriteSheet:initialize(image, quad, tile_size_x, tile_size_y)
    self.txt = txt
    self.image = image

    self.ss_x, self.ss_y, self.ss_w, self.ss_h = quad:getViewport()
    self.ss_w = self.ss_w + self.ss_x
    self.ss_h = self.ss_h + self.ss_y

    self.tile_size_x = tile_size_x
    self.tile_size_y = tile_size_y

    self.quads = {}

    local count = 0
    for x = self.ss_x, self.ss_w - self.tile_size_x, self.tile_size_x do
        count = count + 1
        table.insert(self.quads, {})
        for y=self.ss_y, self.ss_h - self.tile_size_y, self.tile_size_y do
            local quad = love.graphics.newQuad(x, y, tile_size_x,
                                               tile_size_y,
                                               image:getDimensions())
            table.insert(self.quads[count], quad)
        end
    end
end

function SpriteSheet:get_image()
    return self.image
end


function SpriteSheet:get_quad(x, y)
    return self.quads[x][y]
end

function SpriteSheet:get_quads_len()
    return { #self.quads, #self.quads[1] }
end


return SpriteSheet
