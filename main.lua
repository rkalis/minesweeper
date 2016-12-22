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
--   checkNeighbours function is called, in which a cascading algorithm is
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

assets = require "assets.assets"
Gamestate = require "lib.gamestate"

states = {
    menu = require "states.menu",
    pregame = require "states.pregame",
    game = require "states.game",
    endgame = require "states.endgame",
    enterHighScores = require "states.enterHighScores",
    displayHighScores = require "states.displayHighScores"
}

local Game = require "src.game"


-- This is the entrypoint of the code, here variables are initialised and the
-- initial state is set
function love.load()
    -- Random seed with a few calibration randoms
    math.randomseed(os.time())
    math.random(); math.random(); math.random(); math.random();

    love.graphics.setBackgroundColor(170,170,170)
    love.graphics.setFont(love.graphics.newFont(15))

    Gamestate.registerEvents()
    local game = Game:new()
    Gamestate.switch(states.menu, game)
end

function love.draw()
    local game = Gamestate:current().game
    game.ui.buttons.medium.smiley = "def"

    if love.mouse.isDown(1) then
        local cell = game.board:mouseToCell(love.mouse.getX(), love.mouse.getY())
        if cell and not cell.checked and not cell.flagged then
            game.ui.buttons.medium.smiley = "o"
        end
    end

    game.board:draw()

    -- Draws the buttons
    for option, button in pairs(game.ui.buttons) do
        button:draw()
    end
end
