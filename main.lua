-- LuaSweeper/main.lua

-- * This application runs my personal version of the famous game Minesweeper.
-- * At the start the user is asked to select a difficulty. Based on this
--   selection the total number of mines will be determined.
-- * A user then starts the game and the timer by cl[icking a cell on the field.
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
-- * All graphics and sound effects except for the button template were made by
--   me. I can't remember where I found the button template, but that is hardly
--   plagiarism.

assets = require("assets")
require("cell")
require("button")
require("highscores")

-- The love.load function is called at the start of the game.
-- In this function some variables are initialised.
-- The title and the background colour are set.
-- Graphics as well as audio are saved for use in the application,
-- grouped in tables.
-- File objects are created for the highscore files.
-- Button objects are created and a two-dimensional table is created and filled
-- with cell objects for every cell on the game board.
-- Lastly the state is set to menu.
function love.load()
    total_flags = 0
    total_mines = 0

    outcome = "win"
    font = love.graphics.newFont(15)
    ended = false
    start_time = 0
    score = 0
    input = ""
    time = 0
    difficulty = "medium"

    love.graphics.setBackgroundColor(170,170,170)

    -- Create highscores
    highscores = Highscores:new("highscores_easy.txt",
                                "highscores_medium.txt",
                                "highscores_hard.txt")

    -- Button initialisation
    buttons = {
        easy   = Button:new(WINDOW_WIDTH * 1/4 - 30, 20),
        medium = Button:new(WINDOW_WIDTH * 1/2 - 30, 20),
        hard   = Button:new(WINDOW_WIDTH * 3/4 - 30, 20)
    }
    buttons.easy.smiley = "green"
    buttons.hard.smiley = "red"

    -- Cells initialisattion
    board = {}
    for i = 0, NUM_ROWS - 1 do
        board[i] = {}
        for j = 0, NUM_COLS - 1 do
            board[i][j] = Cell:new(j * CELL_SIZE, i * CELL_SIZE + STATS_HEIGHT)
        end
    end

    state = "menu"
end

-- love.update function is called continuously during the game. I used it
-- mainly for time related events since it lends itself very well for these
-- kind of operations as it passes a delta time variable.
function love.update(dt)
    if state == "play" then
        score = score + dt
    elseif state == "endgame" then
        if time == 0 then
            love.audio.play(assets.audio[outcome])
        end
        time = time + dt
        for i = 0, NUM_ROWS - 1 do
            for j = 0, NUM_COLS - 1 do
                board[i][j]:checkNeighbours(i, j, false)
            end
        end
        if outcome == "win" then
            if time >= 3 then
                state = "highscoresEnter"
            end
        end
    end
end

-- This function places a fixed amount of mines at random places in the
-- board table. It only places a mine in a cell that doesn't already contain
-- a mine. It also doesn't place any mines in the cell or adjacent cells to
-- the cell of which coordinates are passed.
function placeMines(click_x, click_y)
    -- Seeding the random with os.time(), then a few math.random()s are
    -- executed because I read that the first few aren't completely
    -- random, so you should do it like this.
    math.randomseed(os.time())
    math.random(); math.random(); math.random(); math.random();
    mines_placed = 0
    while mines_placed < total_mines do
        -- Get random coordinates
        random_x = math.random(0, NUM_ROWS - 1)
        random_y = math.random(0, NUM_COLS - 1)

        if board[random_x][random_y].mine == false
        and not ((random_x >= click_x - 1 and random_x <= click_x + 1)
        and  (random_y >= click_y - 1 and random_y <= click_y + 1)) then
            board[random_x][random_y].mine = true
            mines_placed = mines_placed + 1
        end
    end
end

-- This function resets the game by calling the love.load fucntion.
function reset()
    love.load()
end

-- This function checks whether the game is won by checking if there are
-- cells left that aren't either a mine or checked. If none are found, the
-- game is won.
function checkWin()
    for i = 0, NUM_ROWS - 1 do
        for j = 0, NUM_COLS - 1 do
            if board[i][j].mine == true or board[i][j].checked == true then
            else
                return false
            end
        end
    end
    return true
end

function love.mousepressed(x, y, button)
    if not(state == "play" or state == "firstmove") then return end
    if y < STATS_HEIGHT then return end
    -- The right button toggles whether the cell is flagged.
    if button == 2 then
        local clicked_x = math.floor((y - STATS_HEIGHT) / CELL_SIZE)
        local clicked_y = math.floor(x / CELL_SIZE)
        cell = board[clicked_x][clicked_y]

        -- TODO: When clearing a flagged cell, total flags is not decremented
        if not cell.flagged and not (cell.checked or cell.clicked) then
            cell.flagged = true
            total_flags = total_flags + 1
        elseif cell.flagged and not (cell.checked or cell.clicked) then
            cell.flagged = false
            total_flags = total_flags - 1
        end
    end
end

-- I decided to use the love.mousereleased function instead of the
-- love.mousepressed function because that makes more sense to me. Like that
-- it is also possible to fix a mistake that was realised just in time.
-- Depending on the state there are different clickable areas with different
-- on-release effects. In the menu there are three difficulty buttons.
-- In the endgame only the reset smiley is clickable, in all other states the
-- game board is clickable, but in the menu, clicking the board has no
-- effect.
function love.mousereleased(x, y, button)
    if state == "menu" then
        -- If one of the three buttons are pressed, the number of mines is
        -- determined and the state changes to firstmove.
        -- TODO: Conflicting name with param, bad style
        for option, button in pairs(buttons) do
            if  (x > button.x and x < button.x + button.width)
            and (y > button.y and y < button.y + button.height) then
                if option == "easy" then mines_percentage = 11
                elseif option == "medium" then mines_percentage = 17
                elseif option == "hard" then mines_percentage = 23 end
                total_mines = math.ceil(mines_percentage / 100 * NUM_COLS * NUM_ROWS)

                difficulty = option

                buttons.easy = nil
                buttons.hard = nil

                state = "firstmove"
            end
        end

    elseif state == "play" or state == "firstmove" then
        -- If the coordinates are outside of the stats bar
        if y > STATS_HEIGHT then

            -- This translates the coordinates into indices for the
            -- board table.
            local clicked_x = math.floor((y - STATS_HEIGHT) / CELL_SIZE)
            local clicked_y = math.floor(x / CELL_SIZE)
            cell = board[clicked_x][clicked_y]

            if button == 1 then
                if not cell.flagged then
                    cell.clicked = true
                    if cell.mine then
                        outcome = "lose"
                        state = "endgame"
                    end
                    if state == "firstmove" then
                        placeMines(clicked_x, clicked_y)
                        start_time = love.timer.getTime()
                        state = "play"
                    end
                    cell:checkNeighbours(clicked_x, clicked_y, true)

                    -- It is checked after each left click whether this click
                    -- has caused victory.
                    if(checkWin()) then
                        state = "endgame"
                    end
                end
            end
        -- If the smiley is clicked the game is reset.
        elseif  (x > buttons.medium.x and x < buttons.medium.x + buttons.medium.width)
            and (y > buttons.medium.y and y < buttons.medium.y + buttons.medium.height) then
            reset()
        end
    -- If the smiley is clicked the game is reset.
    elseif state == "endgame" or state == "highscoresEnter"
        or state == "highscoresDisplay" then
            if  (x > buttons.medium.x and x < buttons.medium.x + buttons.medium.width)
            and (y > buttons.medium.y and y < buttons.medium.y + buttons.medium.height) then
            reset()
        end
    end
end

-- The only time this function is used is when the game state is
-- highscoresEnter, then it appends the pressed key to the input variable
-- if it's an alphanumerical key and input is 10 characters long at most.
-- If the backspace key is pressed, the last character in the input variable
-- is removed. If return is pressed the score is submitted to the high scores
-- with the input as name, but only if the input is not blank.
-- Then the high scores are loaded, sorted, and saved. After which they are
-- displayed.
function love.keypressed(key)
    if state == "highscoresEnter" then
        if input:len() < 10 then
            if key and key:match('^[%w]$') then
                input = input .. key:upper()
            end
        end
        if key == "backspace" then
            input = input:sub(1, -2)
        elseif key == "return" then
            if input ~= "" then
                name = input
                highscores:addScore(difficulty, name, score)
            end
            state = "highscoresDisplay"
        end
    end
end

-- DRAWING FUNCTIONS:

-- love.draw is called continuously during the game. It draws the playing
-- field. For the different states there are (slightly) different looking
-- game boards.
function love.draw()
    buttons.medium.smiley = "def"
    -- The stats bar:

    -- The stats bar while the game is in progress or has ended.
    -- It includes the number of mines remaining and the time, as well as the
    -- smiley.
    if state == "play" or state == "firstmove" or state == "endgame"
    or state == "highscoresEnter" or state == "highscoresDisplay" then
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(font)

        love.graphics.printf("Mines remaining: " .. (total_mines - total_flags),
                             WINDOW_WIDTH / 2 + 35, STATS_HEIGHT / 2,
                             WINDOW_WIDTH / 2 - 40, "center")

        if state == "firstmove" then
            love.graphics.print("Time: 0", WINDOW_WIDTH * 1/5 - 20,
                                STATS_HEIGHT / 2)
        else
            love.graphics.print("Time: " .. (math.floor(score)),
                                WINDOW_WIDTH * 1/5 - 20, STATS_HEIGHT / 2)
        end
    -- The stats bar when the game is in menu.
    -- It includes three buttons for each difficulty.
    elseif state == "menu" then
        love.graphics.setColor(255,255,255)
        for option, button in pairs(buttons) do
            button:draw()
        end
    end

    -- The game board:

    -- Draws the standard board
    if state == "play" or state == "menu" or
       state == "firstmove" or state == "endgame" or
       state == "highscoresEnter" or state == "highscoresDisplay" then
        for i = 0, NUM_ROWS - 1 do
            for j = 0, NUM_COLS - 1 do
                board[i][j]:draw()
            end
        end
    end
    -- Draws the smiley that corresponds with the outcome
    if state == "endgame" then
        buttons.medium.smiley = outcome
    end

    -- The high score overlay:

    -- Draws the fully revealed board. Over it a rectangle is drawn.

    -- An input box is drawn over the board, as well as the input the
    -- user gives.
    if state == "highscoresEnter" then
        buttons.medium.smiley = outcome
        love.graphics.setColor(0,0,0)
        love.graphics.rectangle("line", WINDOW_WIDTH / 2 - 100,
                                WINDOW_HEIGHT / 2 - 50, 200, 100)
        love.graphics.setColor(200,200,200)
        love.graphics.rectangle("fill", WINDOW_WIDTH / 2 - 100,
                                WINDOW_HEIGHT / 2 - 50, 200, 100)
        love.graphics.setColor(0,0,0)
        love.graphics.printf("YOUR NAME: ", WINDOW_WIDTH / 2 - 50,
                             WINDOW_HEIGHT / 2 - 30, 100, "center")
        love.graphics.rectangle("line", WINDOW_WIDTH / 2 - 50,
                                WINDOW_HEIGHT / 2 - 10, 100, 20)
        love.graphics.setColor(255,255,255)
        love.graphics.rectangle("fill", WINDOW_WIDTH / 2 - 50,
                                WINDOW_HEIGHT / 2 - 10, 100, 20)
        love.graphics.setColor(0,0,0)
        love.graphics.printf(input, WINDOW_WIDTH / 2 - 49,
                             WINDOW_HEIGHT / 2 - 10, 98, "left")
    -- A rectangle is drawn over the board, as well as the list of high scores.
    elseif state == "highscoresDisplay" then
        buttons.medium.smiley = outcome
        highscores:draw(difficulty)
    end
    love.graphics.setColor(255,255,255)
    for option, button in pairs(buttons) do
        button:draw()
    end
end
