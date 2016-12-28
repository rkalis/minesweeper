local kalis = require "lib.kalis"
local Highscores = {}

-- Creates new highscores at the given files, creating the files if they
-- didn't exist already
function Highscores:new(easy_fn, medium_fn, hard_fn)
    -- Creates high score files if the don't alreasy exist
    if not love.filesystem.exists(easy_fn) then
        love.filesystem.write(easy_fn, "")
    end
    if not love.filesystem.exists(medium_fn) then
        love.filesystem.write(medium_fn, "")
    end
    if not love.filesystem.exists(hard_fn) then
        love.filesystem.write(hard_fn, "")
    end
    local obj = {
        files = {
            easy   = love.filesystem.newFile(easy_fn),
            medium = love.filesystem.newFile(medium_fn),
            hard   = love.filesystem.newFile(hard_fn)
        },
        highscores = {
            easy = {},
            medium = {},
            hard = {}
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
    self.files[difficulty]:open("r")
    local temp = kalis.iter_all(self.files[difficulty]:lines())

    -- This saves the different variables in the file (seperated by a space)
    -- to the highscores table as seperate variables within a table.
    for i = 1, 10 do
        if temp[i] then
            self.highscores[difficulty][i] = {}
            local score = kalis.iter_all(string.gmatch(temp[i], "(%w+)"))
            if #score == 2 and tonumber(score[2]) then
                self.highscores[difficulty][i][1] = score[1]
                self.highscores[difficulty][i][2] = tonumber(score[2])
            else
                table.remove(temp, i)
                i = i - 1
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
        if  self.highscores[difficulty][i]
        and self.highscores[difficulty][i][1]
        and self.highscores[difficulty][i][2] then
            local name = self.highscores[difficulty][i][1]
            local score = self.highscores[difficulty][i][2]
            self.files[difficulty]:write(name .. " " .. score .. "\n")
        end
    end
    self.files[difficulty]:close()
end

-- Bubble Sort algorithm:
-- Source: http://rosettacode.org/wiki/Sorting_algorithms/Bubble_sort#Lua
-- Edited to work with the highscores table by using the compareTables
-- function.
function Highscores:sort(difficulty)
    local highscores = self.highscores[difficulty]
    local item_count = #highscores
    local has_changed
    repeat
        has_changed = false
        item_count = item_count - 1
        for i = 1, item_count do
            if self.compareScore(highscores[i], highscores[i + 1]) == 1 then
                highscores[i], highscores[i + 1] = highscores[i + 1], highscores[i]
                has_changed = true
            end
        end
    until not has_changed
    self.highscores[difficulty] = highscores
end

-- This resets the highscores of the given difficulty
function Highscores:reset(difficulty)
    self.highscores[difficulty] = {}
    self:save(difficulty)
end

-- This function compares the score part of a high scores entry, and returns
-- -1, 0 or 1 depending on which score is higher.
function Highscores.compareScore(score1, score2)
    if score1[2] ~= nil and score2[2] ~= nil then
        if score1[2] < score2[2] then
            return -1
        elseif score1[2] == score2[2] then
            return 0
        elseif score1[2] > score2[2] then
            return 1
        end
    end
end

function Highscores:addScore(difficulty, name, score)
    self:load(difficulty)
    table.insert(self.highscores[difficulty], {name, math.floor(score)})
    self:sort(difficulty)
    self:save(difficulty)
end

-- TODO: Make this more dynamic
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
        if  self.highscores[difficulty][i]
        and self.highscores[difficulty][i][1]
        and self.highscores[difficulty][i][2] then
            love.graphics.print(i, WINDOW_WIDTH / 2 - 110,
                                   WINDOW_HEIGHT / 2 - 150 + i * 20)
            love.graphics.print(self.highscores[difficulty][i][1],
                                WINDOW_WIDTH / 2 - 80,
                                WINDOW_HEIGHT / 2 - 150 + i * 20)
            love.graphics.print(self.highscores[difficulty][i][2],
                                WINDOW_WIDTH / 2 + 70,
                                WINDOW_HEIGHT / 2 - 150 + i * 20)
        end
    end
    love.graphics.setColor(255,255,255)
end

return Highscores
