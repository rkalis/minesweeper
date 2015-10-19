--  Name          : Rosco Kalis
--  Student ID    : 10771603

-- Minesweeper/main.lua

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

require("cell")

local assets = require("assets/assets")
local highscores = require("highscores")

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
	totalFlags = 0
	victory = true
	font = love.graphics.newFont(15)
	ended = false
	startTime = 0
	score = 0
	minesPercentage = 17
	input = ""
	time = 0
	difficulty = "medium"
	
	love.window.setTitle("Minesweeper Xxtreme Relo4ded 2.0: Retribution")
	love.graphics.setBackgroundColor(170,170,170)
	love.filesystem.setIdentity("Minesweeper")

	-- Creates high score files if the don't alreasy exist, and then
	-- creates File objects for the files.
	if not(love.filesystem.exists("highscores_easy.txt")) then
		love.filesystem.write("highscores_easy.txt", "")
	end
	if not(love.filesystem.exists("highscores_medium.txt")) then
		love.filesystem.write("highscores_medium.txt", "")
	end
	if not(love.filesystem.exists("highscores_hard.txt")) then
		love.filesystem.write("highscores_hard.txt", "")
	end
	highscoresFile = {

		easy = love.filesystem.newFile("highscores_easy.txt"),
		medium = love.filesystem.newFile("highscores_medium.txt"),
		hard = love.filesystem.newFile("highscores_hard.txt")
	}

	highscores = {
		easy = {},
		medium = {},
		hard = {}
	}

	-- Graphics and audio:


	-- Button initialisation
	easy = Button:new(WINDOW_WIDTH * 1/4 - 30, 30)
	medium = Button:new(WINDOW_WIDTH * 1/2 - 30, 30)
	hard = Button:new(WINDOW_WIDTH * 3/4 - 30, 30)

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
		if victory == true then
			time = time + dt
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
function setMines(index1, index2)
	-- Seeding the random with os.time(), then a few math.random()s are 
	-- executed because I read that the first few aren't completely
	-- random, so you should do it like this.
	math.randomseed(os.time())
	math.random(); math.random(); math.random(); math.random();
	for i = 1, totalMines do
		while true do
			random1 = math.random(0, NUM_ROWS - 1)
			random2 = math.random(0, NUM_COLS - 1)
			if board[random1][random2].mine == false 
			and not ((random1 >= index1 - 1 and random1 <= index1 + 1)
			and  (random2 >= index2 - 1 and random2 <= index2 + 1)) then
				board[random1][random2].mine = true
				break
			end
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

-- Loads 11 (the 10 saved from last time + the one from this time)
-- from the highscoresFile to the corresponding highscores table.
-- If there aren't 11, it loads the ones there are. The high scores are 
-- saved as a table with two variables, one for a name and one for a score.
-- This table is saved in the highscores table.
function loadHighscores()
	-- This saves every line in the highscoresFile in a temporary table.
	local temp = {}
	highscoresFile[difficulty]:open("r")
	for line in highscoresFile[difficulty]:lines() do
		table.insert(temp, line)
	end

	-- This saves the different variables in the file (seperated by a space)
	-- to the highscores table as seperate variables within a table. 
	for i = 1, 11 do
		if temp[i] ~= nil then
			index = 1
			highscores[difficulty][i] = {}
			for entry in string.gmatch(temp[i], "(%w+)") do
				if index == 2 then
					entry = tonumber(entry)
				end
				highscores[difficulty][i][index] = entry

				index = index + 1
			end
		end
	end
	highscoresFile[difficulty]:close()
end

-- Saves the top 10 high scores in the highscores table to the highscoresFile.
-- If there aren't 10, it saves the ones there are.
function saveHighscores()
	-- Empty the file
	highscoresFile[difficulty]:open("w")
	highscoresFile[difficulty]:close()
	-- Write to the empty file
	highscoresFile[difficulty]:open("a")
	for i = 1, 10 do
		if  highscores[difficulty][i] ~= nil 
		and highscores[difficulty][i][1]
		and highscores[difficulty][i][2] then
			highscoresFile[difficulty]:write(highscores[difficulty][i][1]
									.. " " .. highscores[difficulty][i][2]
									.. "\n")
		end
	end
	highscoresFile[difficulty]:close()
end

-- Bubble Sort algorithm:
-- Source: http://rosettacode.org/wiki/Sorting_algorithms/Bubble_sort#Lua
-- Edited to work with the highscores table by using the compareTables
-- function.
function bubbleSort(A)
	local itemCount = #A
	local hasChanged
	repeat
		hasChanged = false
		itemCount = itemCount - 1
		for i = 1, itemCount do
			if compareTables(A[i], A[i + 1]) == 1 then
				A[i], A[i + 1] = A[i + 1], A[i]
				hasChanged = true
			end
		end
	until hasChanged == false
end

-- This function compares the score part of a high scores entry, and returns
-- -1, 0 or 1 depending on which score is higher.
function compareTables(table1, table2)
	if table1[2] ~= nil and table2[2] ~= nil then
		if table1[2] < table2[2] then
			return -1
		elseif table1[2] == table2[2] then
			return 0
		elseif table1[2] > table2[2] then
			return 1
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
		if  (x > easy.x and x < easy.x + easy.width) 
		and (y > easy.y and y < easy.y + easy.height) then
			minesPercentage = 11
			difficulty = "easy"
		elseif  (x > medium.x and x < medium.x + medium.width) 
			and (y > medium.y and y < medium.y + medium.height) then
			minesPercentage = 17
			difficulty = "medium"
		elseif  (x > hard.x and x < hard.x + hard.width) 
			and (y > hard.y and y < hard.y + hard.height) then
			minesPercentage = 23
			difficulty = "hard"
		else
			return
		end
		totalMines = math.ceil(minesPercentage / 100 * NUM_COLS * NUM_ROWS)
		state = "firstmove"

	elseif state == "play" or state == "firstmove" then
		-- If the coordinates are outside of the stats bar
		if y > STATS_HEIGHT then

			-- This translates the coordinates into indices for the
			-- board table.
			local index1 = math.floor((y - STATS_HEIGHT) / CELL_SIZE)
			local index2 = math.floor(x / CELL_SIZE)

			if button == "l" then
				if board[index1][index2].flagged == false then
					board[index1][index2].clicked = true
					if state == "firstmove" then
						setMines(index1, index2)
						startTime = love.timer.getTime()
						state = "play"
					end
					board[index1][index2]:checkNeighbours(index1, index2)

					-- It is checked after each left click whether this click
					-- has caused victory.
					if(checkWin() == true) then
						state = "endgame"
					end
				end
			-- The right button toggles whether the cell is flagged.
			elseif button == "r" then
				if  board[index1][index2].flagged == false 
				and board[index1][index2].checked == false 
				and board[index1][index2].clicked == false then
					board[index1][index2].flagged = true
					totalFlags = totalFlags + 1
				elseif  board[index1][index2].flagged == true
					and board[index1][index2].checked == false 
					and board[index1][index2].clicked == false then
					board[index1][index2].flagged = false
					totalFlags = totalFlags - 1
				end
			end
		-- If the smiley is clicked the game is reset.
		elseif  (x > medium.x and x < medium.x + medium.width) 
			and (y > medium.y and y < medium.y + medium.height) then
			reset()
		end
	-- If the smiley is clicked the game is reset.
	elseif state == "endgame" or state == "highscoresEnter"
		or state == "highscoresDisplay" then
		if  	(x > medium.x and x < medium.x + medium.width) 
			and (y > medium.y and y < medium.y + medium.height) then
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
				
				highscoresFile[difficulty]:open("a")
				highscoresFile[difficulty]:write(name .. " " 
												 .. math.floor(score) .. "\n")
				highscoresFile[difficulty]:close()
				
			end
			loadHighscores()
			bubbleSort(highscores[difficulty])
			saveHighscores()
			state = "highscoresDisplay"
		end
	end
end

-- DRAWING FUNCTIONS:

-- love.draw is called continuously during the game. It draws the playing
-- field. For the different states there are (slightly) different looking
-- game boards.
function love.draw()
	-- The stats bar:

	-- The stats bar while the game is in progress or has ended.
	-- It includes the number of mines remaining and the time, as well as the
	-- smiley.
	if state == "play" or state == "firstmove" or state == "endgame" 
	or state == "highscoresEnter" or state == "highscoresDisplay" then
		love.graphics.setColor(255,255,255)
		drawSmiley("def", medium.x, medium.y)

		love.graphics.setColor(0,0,0)
		love.graphics.setFont(font)

		love.graphics.printf("Mines remaining: " .. (totalMines - totalFlags),
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
		love.graphics.setColor(0,0,0)
		love.graphics.setFont(font)

		love.graphics.print("EASY", easy.x + 10, 10)
		love.graphics.print("MEDIUM", medium.x, 10)
		love.graphics.print("HARD", hard.x + 7.5, 10)

		love.graphics.setColor(255,255,255)
		drawSmiley("def", easy.x, easy.y)
		drawSmiley("def", medium.x, medium.y)
		drawSmiley("def", hard.x, hard.y)
	end

	-- The game board:

	-- Draws the standard board if the state is not endgame.
	if state == "play" or state == "menu" or state == "firstmove" then
		for i = 0, NUM_ROWS - 1 do
			for j = 0, NUM_COLS - 1 do
				dispCell(board[i][j])
				dispMouseDown(board[i][j])
			end
		end

	-- Draws the fully revealed board at the end of the game.
	elseif state == "endgame" then
		if victory == true then
			endgame("win")
		elseif victory == false then
			endgame("lose")
		end
	end

	-- The high score overlay:

	-- Draws the fully revealed board. Over it a rectangle is drawn.

	-- An input box is drawn over the board, as well as the input the 
	-- user gives.
	if state == "highscoresEnter" then
		endgame("win")
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
		endgame("win")
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("line", WINDOW_WIDTH / 2 - 125,
								WINDOW_HEIGHT / 2 - 200, 250, 400)
		love.graphics.setColor(200,200,200)
		love.graphics.rectangle("fill", WINDOW_WIDTH / 2 - 125,
								WINDOW_HEIGHT / 2 - 200, 250, 400)
		love.graphics.setColor(0,0,0)
		love.graphics.printf("HIGH SCORES:", WINDOW_WIDTH / 2 - 125,
							 WINDOW_HEIGHT / 2 - 190, 250, "center")
		for i = 1, 10 do
			if highscores[difficulty][i] ~= nil 
			and highscores[difficulty][i][1] ~= nil
			and highscores[difficulty][i][2] ~= nil then
				love.graphics.print(i, WINDOW_WIDTH / 2 - 110, 
									   WINDOW_HEIGHT / 2 - 150 + i * 20)
				love.graphics.print(highscores[difficulty][i][1], 
									WINDOW_WIDTH / 2 - 80, 
									WINDOW_HEIGHT / 2 - 150 + i * 20)
				love.graphics.print(highscores[difficulty][i][2],
									WINDOW_WIDTH / 2 + 70,
									WINDOW_HEIGHT / 2 - 150 + i * 20)
			end
		end
	end
end

-- This function displays a cell depending on the state it is in.
-- If the state is clicked and it is a mine, the game is lost and the state
-- changes to endgame.
function dispCell(cell)
	love.graphics.setColor(255,255,255)
	if cell.clicked == true and cell.mine == true then
		victory = false
		state = "endgame"
		
		love.graphics.draw(block.bomb_clicked, cell.x, cell.y, 0, 
						   cell.size / 120)
	elseif cell.checked == true then
		dispNumbers(cell)
	elseif cell.flagged == true then
		love.graphics.draw(block.flag, cell.x, cell.y, 0, cell.size / 120)
	else
		love.graphics.draw(block.unclicked, cell.x, cell.y, 0, cell.size / 120)
	end
	love.graphics.setColor(100,100,100)
	love.graphics.rectangle("line", cell.x, cell.y, cell.size, cell.size)
end

-- This function displays the number of mines in the adjacent cells, if there
-- aren't any, an empty cell is displayed.
function dispNumbers(cell)
	love.graphics.setColor(255,255,255)
	if cell.numMines == 0 then
		love.graphics.draw(block.clicked, cell.x, cell.y, 0, cell.size / 120)
	else
		love.graphics.draw(block[cell.numMines], 
						   cell.x, cell.y, 0, cell.size / 120)
	end
end

-- This function displays a clicked cell when the mouse is down on that cell.
-- It also changes the smiley to one with an opened mouth when the mouse is
-- down.
function dispMouseDown(cell)
	if  (love.mouse.isDown("l") or love.mouse.isDown("r"))
	and (love.mouse.getX() > cell.x and love.mouse.getX() 
	<    cell.x + cell.size) and (love.mouse.getY()
	>    cell.y and love.mouse.getY() < cell.y + cell.size
	and  cell.checked == false) then
	  	love.graphics.setColor(255,255,255)
	  	love.graphics.draw(block.clicked, cell.x, cell.y, 0, cell.size / 120)
		drawSmiley("o", medium.x, medium.y)
		if state == "menu" then
			drawSmiley("o", easy.x, easy.y)
			drawSmiley("o", hard.x, hard.y)
		end
	end
end

-- This function draws a smiley of the passed type at the passed coordinates.
function drawSmiley(type, x, y)
	love.graphics.draw(smiley[type], x, y, 0, 1/2)
end

-- This function stops the timer and plays the associated audio fragment at the
-- end of the game. It also reveals the entire game board, showing where
-- all the bombas are. It also shows where incorrect flags were placed.
function endgame(outcome)
	-- This displays the game board after the game is over.
	for i = 0, NUM_ROWS - 1 do
		for j = 0, NUM_COLS - 1 do
			-- If the outcome is a loss, then the board first needs to be
			-- cleared, if it's a win, the board already is cleared.
			if outcome == "lose" then
				board[i][j]:checkNeighbours(i, j)
			end
			dispCell(board[i][j])
			if board[i][j].mine == true and board[i][j].clicked == false then
				love.graphics.setColor(255,255,255)
				love.graphics.draw(block.bomb, board[i][j].x, board[i][j].y,
								   0, board[i][j].size / 120)
			elseif board[i][j].mine == false and board[i][j].flagged == true 
				then
				love.graphics.setColor(255,255,255)
				love.graphics.draw(block.bomb_wrong, board[i][j].x, 
								   board[i][j].y, 0, board[i][j].size / 120)
			end
			love.graphics.setColor(100,100,100)
			love.graphics.rectangle("line", board[i][j].x, board[i][j].y,
									board[i][j].size, board[i][j].size)
		end
	end
	-- This draws a smiley depending on the outcome
	love.graphics.setColor(255,255,255)
	drawSmiley(outcome, medium.x, medium.y)
	-- These things only need to be executed only once at the end of the game:
	-- the endgame audio is played. Then ended is set to true so that it won't 
	-- repeat each time the endgame function is called in the love.draw 
	-- function. 
	if ended == false then
		love.audio.play(audio[outcome])
		ended = true
	end
end
