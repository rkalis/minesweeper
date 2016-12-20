local Board = require "board"
local Button = require "button"
local Highscores = require "highscores"
local UI = require "UI"

local Game = {}

function Game:new()
    local obj = {
        total_flags = 0,
        total_mines = 0,
        outcome = "win",
        start_time = 0,
        score = 0,
        difficulty = "medium",
        highscores = Highscores:new("highscores_easy.txt",
                                    "highscores_medium.txt",
                                    "highscores_hard.txt"),
        ui = UI:new(WINDOW_WIDTH / 2 + 40, STATS_HEIGHT / 2,
                    WINDOW_WIDTH * 1/5 - 20, STATS_HEIGHT / 2),
        buttons = {
            easy   = Button:new(WINDOW_WIDTH * 1/4 - 30, 20),
            medium = Button:new(WINDOW_WIDTH * 1/2 - 30, 20),
            hard   = Button:new(WINDOW_WIDTH * 3/4 - 30, 20)
        },
        board = Board:new(NUM_COLS, NUM_ROWS, CELL_SIZE, STATS_HEIGHT)
    }
    obj.buttons.easy.smiley = "green"
    obj.buttons.hard.smiley = "red"

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Game:reset()
    self = Game:new()
    return self
end

return Game
