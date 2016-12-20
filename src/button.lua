local kalis = require "lib.kalis"

-- The button table prototypes a clickable button such as the smiley buttons.
-- A button has a height, width and coordinates. A button can be clicked.
local Button = {}

function Button:new(x, y)
    local obj = {
        x = x,
        y = y,
        width = 60,
        height = 60,
        clicked = false,
        smiley = "def"
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Button:draw()
    local smiley = assets.graphics.smiley[self.smiley]
    love.graphics.draw(smiley, self.x, self.y, 0, 1/2)
end

-- Checks if the button is clicked by the mouse at coords (mouse_x, mouse_y)
function Button:isClicked(mouse_x, mouse_y)
    return kalis.is_clicked(self, mouse_x, mouse_y)
end

return Button
