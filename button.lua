-- The button table prototypes a clickable button such as the smiley buttons.
-- A button has a height, width and coordinates. A button can be clicked.
Button = {
    x,
    y,
    width = 60,
    height = 60,
    clicked = false,
    smiley = "def"
}

function Button:new(x, y)
    obj = {
        x = x,
        y = y
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Button:draw()
    smiley = assets.graphics.smiley[self.smiley]
    love.graphics.draw(smiley, self.x, self.y, 0, 1/2)
end
