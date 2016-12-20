-- LuaSweeper/main.lua

-- * This application runs my personal version of the famous game Minesweeper.
-- * At the start the user can select a difficulty. Based on this
--   selection the total number of mines will be determined.
-- * A user then starts the game and the timer by clicking a cell on the field.
-- * A number of cells will be selected to be mines at random, but they can not
--   be the initially clicked cell or any of its neighbours.
-- * If a cell is right clicked, the cell will be flagged, marking it as a mine,
--   and making it unable to be left clicked until the flag is removed again.
-- * If a cell is left clicked its clicked state is set to true and the
--   checkNeigbours function is called, in which a cascading algorithm is
--   executed.
-- * After cascading, the number of surrounding mines is displyed in every
--   revealed cell unless there are none, then nothing is displayed in the
--   cell.
-- * There are two ways to end the game:
--   - A cell which contains a mine is clicked
--   - All cells on the board are either revealed or mines
-- * As soon as one of these requirements is met, the game state changes to
--   endgame and the board is completely revealed.
-- * After three seconds the user is prompted to enter their name, after which
--   the high scores are shown.
-- * If at any time the smiley at the top of the game board is clicked, the
--   game is reset.
-- * Another thing that could be nice to add to the game would be custom
--   game modes, in which the user enters a number of columns, a number of rows,
--   and a cell size, and based on these variables the board is created.
--   It is already possible to do this through the conf.lua file, but it would
--   be nice to add end-user support for this. A man can only do so much in a
--   week though.
-- * All graphics and sound effects were made by me.

assets = require("assets")
Gamestate = require("lib/gamestate")
utils = require("lib/utils")
states = {
    menu = require("states/menu"),
    preGame = require("states/preGame"),
    game = require("states/game"),
    endgame = require("states/endgame"),
    enterHighScores = require("states/enterHighScores"),
    displayHighScores = require("states/displayHighScores")
}

UI = require "UI"

require("cell")
require("board")
require("button")
require("highscores")

-- This is the entrypoint of the code, here variables are initialised and the
-- initial state is set
function love.load()
    Gamestate.registerEvents()
    init()
end

function init()
    -- Random seed with a few calibration randoms
    math.randomseed(os.time())
    math.random(); math.random(); math.random(); math.random();

    -- Variable initialisation
    total_flags = 0
    total_mines = 0
    outcome = "win"
    ended = false
    start_time = 0
    score = 0
    input = ""
    -- time = 0
    difficulty = "medium"

    font = love.graphics.newFont(15)
    love.graphics.setBackgroundColor(170,170,170)

    -- Highscores initialisation
    highscores = Highscores:new("highscores_easy.txt",
                                "highscores_medium.txt",
                                "highscores_hard.txt")

    ui = UI:new(font, WINDOW_WIDTH / 2 + 40, STATS_HEIGHT / 2,
                WINDOW_WIDTH * 1/5 - 20, STATS_HEIGHT / 2)

    -- Button initialisation
    buttons = {
        easy   = Button:new(WINDOW_WIDTH * 1/4 - 30, 20),
        medium = Button:new(WINDOW_WIDTH * 1/2 - 30, 20),
        hard   = Button:new(WINDOW_WIDTH * 3/4 - 30, 20)
    }
    buttons.easy.smiley = "green"
    buttons.hard.smiley = "red"

    -- Cells initialisattion
    board = Board:new(NUM_COLS, NUM_ROWS, CELL_SIZE, STATS_HEIGHT)

    Gamestate.switch(states.menu)
    state = "menu"
end

function reset()
    init()
end

function checkWin()
    for _, row in utils.ipairs(board) do
        for _, cell in utils.ipairs(row) do
            if not (cell.mine or cell.checked) then
                return false
            end
        end
    end
    return true
end


-- DRAWING FUNCTIONS:

-- love.draw is called continuously during the game. It draws the playing
-- field. For the different states there are (slightly) different looking
-- game boards.
function love.draw()
    buttons.medium.smiley = "def"

    -- Draws the board
    for _, row in utils.ipairs(board) do
        for _, cell in utils.ipairs(row) do
            cell:draw()

            -- Sets the smiley O-face
            if not cell.checked and not cell.flagged and love.mouse.isDown(1)
               and utils.is_clicked(cell, love.mouse.getX(),
                                          love.mouse.getY()) then
                buttons.medium.smiley = "o"
           end
        end
    end

    -- Draws the buttons
    for option, button in pairs(buttons) do
        button:draw()
    end
end
