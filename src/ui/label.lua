local Label = {}

function Label:new(x, y, text)
    local obj = {
        x = x,
        y = y,
        text = text
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Label:draw(value)
    local val = value or ""
    love.graphics.setColor(0,0,0)
    love.graphics.print(self.text .. val, self.x, self.y)
    love.graphics.setColor(255,255,255)
end


return Label
