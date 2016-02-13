Highscores = {
    files = {
        easy,
        medium,
        hard
    },
    highscores = {
        easy = {},
        medium = {},
        hard = {}
    }
}

function Highscores:new(easy_fn, medium_fn, hard_fn)
    -- Creates high score files if the don't alreasy exist
    if not(love.filesystem.exists(easy_fn)) then
        love.filesystem.write(easy_fn, "")
    end
    if not(love.filesystem.exists(medium_fn)) then
        love.filesystem.write(medium_fn, "")
    end
    if not(love.filesystem.exists(hard_fn)) then
        love.filesystem.write(hard_fn, "")
    end
    obj = {
        files = {
            easy = love.filesystem.newFile(easy_fn),
            medium = love.filesystem.newFile(medium_fn),
            hard   = love.filesystem.newFile(hard_fn)
        }
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- Loads 11 (the 10 saved from last time + the one from this time)
-- from the highscoresFile to the corresponding highscores table.
-- If there aren't 11, it loads the ones there are. The high scores are 
-- saved as a table with two variables, one for a name and one for a score.
-- This table is saved in the highscores table.
function Highscores:load(difficulty)
    -- This saves every line in the highscoresFile in a temporary table.
    local temp = {}
    self.files[difficulty]:open("r")
    for line in self.files[difficulty]:lines() do
        table.insert(temp, line)
    end

    -- This saves the different variables in the file (seperated by a space)
    -- to the highscores table as seperate variables within a table. 
    for i = 1, 11 do
        if temp[i] ~= nil then
            index = 1
            self.highscores[difficulty][i] = {}
            for entry in string.gmatch(temp[i], "(%w+)") do
                if index == 2 then
                    entry = tonumber(entry)
                end
                self.highscores[difficulty][i][index] = entry
                index = index + 1
            end
        end
    end
    self.files[difficulty]:close()
end

-- Saves the top 10 high scores in the highscores table to the highscoresFile.
-- If there aren't 10, it saves the ones there are.
function Highscores:save(difficulty)
    -- Empty the file
    self.files[difficulty]:open("w")
    self.files[difficulty]:close()

    -- Write to the empty file
    self.files[difficulty]:open("a")
    for i = 1, 10 do
        if  self.highscores[difficulty][i] ~= nil 
        and self.highscores[difficulty][i][1]
        and self.highscores[difficulty][i][2] then
            self.files[difficulty]:write(self.highscores[difficulty][i][1]
                                        .. " " .. self.highscores[difficulty][i][2]
                                        .. "\n")
        end
    end
    self.files[difficulty]:close()
end

function Highscores:draw(difficulty)
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
        if self.highscores[difficulty][i] ~= nil 
        and self.highscores[difficulty][i][1] ~= nil
        and self.highscores[difficulty][i][2] ~= nil then
            love.graphics.print(i, WINDOW_WIDTH / 2 - 110, 
                                   WINDOW_HEIGHT / 2 - 150 + i * 20)
            love.graphics.print(highscores.highscores[difficulty][i][1], 
                                WINDOW_WIDTH / 2 - 80, 
                                WINDOW_HEIGHT / 2 - 150 + i * 20)
            love.graphics.print(highscores.highscores[difficulty][i][2],
                                WINDOW_WIDTH / 2 + 70,
                                WINDOW_HEIGHT / 2 - 150 + i * 20)
        end
    end
end

-- Bubble Sort algorithm:
-- Source: http://rosettacode.org/wiki/Sorting_algorithms/Bubble_sort#Lua
-- Edited to work with the highscores table by using the compareTables
-- function.
function Highscores:sort(difficulty)
    local A = self.highscores[difficulty]
    local itemCount = #A
    local hasChanged
    repeat
        hasChanged = false
        itemCount = itemCount - 1
        for i = 1, itemCount do
            if self.compareScore(A[i], A[i + 1]) == 1 then
                A[i], A[i + 1] = A[i + 1], A[i]
                hasChanged = true
            end
        end
    until hasChanged == false
    self.highscores[difficulty] = A
end

function Highscores:reset(difficulty)
    self.highscores[difficulty] = {}
    self:save(difficulty)
end

-- This function compares the score part of a high scores entry, and returns
-- -1, 0 or 1 depending on which score is higher.
function Highscores.compareScore(table1, table2)
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