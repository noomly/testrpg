local Level = class('Level')


-- 15 lines in spritesheet
function Level:initialize(lvl_data, world, sp)
    self.lvl_data = lvl_data
    self.world = world
    self.sp = sp

    self.tiles = {}

    local temp = require("res/til/basictiles")

    local col = 0
    local line = 1
    for x, xv in ipairs(self.lvl_data.layers[1].data) do
        if col == self.lvl_data.width then
            col = 1
            line = line + 1
        else
            col = col + 1
        end

        local spy = math.ceil(xv / self.sp:get_quads_len()[1])
        if spy > 1 then
            spx = xv - ((spy - 1) * self.sp:get_quads_len()[1])
        end

        if col == 1 then
            table.insert(self.tiles, {})
        end

        table.insert(self.tiles[line], util.deepcopy(temp[xv]))

        if self.tiles[line][col].solid then
            self.world:add(self.tiles[line][col], (col - 1) * TILE_SIZE_O,
                (line - 1) * TILE_SIZE_O, TILE_SIZE_O, TILE_SIZE_O)
        end
    end
    util.rprint(self.tiles)
end

function Level:draw()
    --local view = self.lvl_data.width * (self.viewy - 1) + self.viewx
    --print("VIEW:", view)

    local col = 0
    local line = 1
    for x, xv in ipairs(self.lvl_data.layers[1].data) do
        if col == self.lvl_data.width then
            col = 1
            line = line + 1
        else
            col = col + 1
        end

        spy = math.ceil(xv / self.sp:get_quads_len()[1])
        if spy > 1 then
            spx = xv - ((spy - 1) * self.sp:get_quads_len()[1])
        else
            spx = xv
        end

        --print("LEN:", unpack(self.sp:get_quads_len()))
        --print("SPX:", spx, "; SPY:", spy, "; XV", xv)
        --print("COL:", col, "; LINE:", line)

        love.graphics.draw(self.sp:get_image(),
           self.sp:get_quad(spx, spy),
           (col - 1) * TILE_SIZE_O, (line - 1) * TILE_SIZE_O)
    end
    --print(unpack(self.sp:get_quads_len()))
end


return Level
