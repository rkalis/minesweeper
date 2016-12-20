local Label = require "src.ui.label"
local Button = require "src.ui.button"
local UI = {}

function UI:new(width, height)
    local obj = {
        labels = {
            mines = Label:new(width / 2 + 40, height / 2, "Mines remaining: "),
            time  = Label:new(width * 1/5 - 20, height / 2, "Time: ")
        },
        buttons = {
            easy   = Button:new(width * 1/4 - 30, 20),
            medium = Button:new(width * 1/2 - 30, 20),
            hard   = Button:new(width * 3/4 - 30, 20)
        }
    }
    obj.buttons.easy.smiley = "green"
    obj.buttons.hard.smiley = "red"

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function UI:draw(mines, score)
    self.labels.mines:draw(mines)
    self.labels.time:draw(score)

    for _, button in pairs(self.buttons) do
        button:draw()
    end
end

return UI
