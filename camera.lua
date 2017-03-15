local Camera = class('Camera')


function Camera:initialize(cx, cy)
    self.cx = cx
    self.cy = cy
end

function Camera:center_on(cx, cy)
    self.cx = self.cx + (self.cx - cx)
    self.cy = self.cy + (self.cy - cy)
end

function Camera:get_pos()
    return self.cx, self.cy
end


return Camera
