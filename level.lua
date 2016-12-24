local Level = class('Level')


-- 15 lines in spritesheet
function Level:initialize(lvl_data, world, sp)
    self.lvl_data = lvl_data
    self.world = world
    self.sp = sp
end

function Level:draw()
    col = 1
    line = 1
    for x, xv in ipairs(self.lvl_data.layers[1].data) do
        if col == self.lvl_data.width then
            col = 1
            line = line + 1
        else
            col = col + 1
        end

        spy = math.ceil(xv / self.sp:get_quads_len()[2])
        if spy > 1 then
            spx = xv - (spy * self.sp:get_quads_len()[1])
        else
            spx = xv
        end

        print("SPX:", spx, "; SPY:", spy, "; XV", xv)

        love.graphics.draw(self.sp:get_image(),
           self.sp:get_quad(spx, spy),
           (col) * TILE_SIZE_SP, (line) * TILE_SIZE_SP)
    end
    print(unpack(self.sp:get_quads_len()))
end


return Level
