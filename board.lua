local Cell = require "cell"
local kalis = require "lib/kalis"

Board = {}

function Board:new(width, height, cell_size, start_of_board)
    local obj = {
        start_of_board = start_of_board,
        cell_size = cell_size
    }

    -- Set cells
    for i = 0, height - 1 do
        obj[i] = {}
        for j = 0, width - 1 do
            obj[i][j] = Cell:new(j * cell_size, i * cell_size + start_of_board,
                                 cell_size)
        end
    end

    -- Set cell neighbours
    for i = 0, height - 1 do
        for j = 0, width - 1 do
            obj[i][j].neighbours = {}
            for di = -1, 1 do
                for dj = -1, 1 do
                    if not (di == 0 and dj == 0)
                    and (i + di >= 0 and i + di <= height - 1)
                    and (j + dj >= 0 and j + dj <= width - 1) then
                        table.insert(obj[i][j].neighbours, obj[i + di][j + dj])
                    end
                end
            end
        end
    end

    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- This function places a fixed amount of mines at random places in the
-- board table. It doesn't place any mines in the clicked cell or adjacent
-- cells to the clicked cell.
function Board:placeMines(clicked_cell, total_mines)
    local mines_placed = 0
    while mines_placed < total_mines do
        local random_cell = self:getRandomCell()

        if not random_cell.mine and not random_cell:equals(clicked_cell) and
           not random_cell:isNeighbour(clicked_cell) then
            random_cell.mine = true
            mines_placed = mines_placed + 1
        end
    end
end

function Board:getCell(x, y)
    if not x or not y then return nil end
    return self[y][x]
end

function Board:getRandomCell()
    local random_row = self[math.random(0, #self)]
    return random_row[math.random(0, #random_row)]
end

function Board:mouseToCell(mouse_x, mouse_y)
    return self:getCell(self:mouseToBoard(mouse_x, mouse_y))
end

function Board:mouseToBoard(mouse_x, mouse_y)
    if mouse_y < self.start_of_board then return nil end
    local clicked_y = math.floor((mouse_y - self.start_of_board) / self.cell_size)
    local clicked_x = math.floor(mouse_x / self.cell_size)
    return clicked_x, clicked_y
end

function Board:clear()
    for _, row in kalis.ipairs(self) do
        for _, cell in kalis.ipairs(row) do
            cell:checkNeighbours(false)
        end
    end
end

function Board:isCleared()
    for _, row in kalis.ipairs(self) do
        for _, cell in kalis.ipairs(row) do
            if not cell.mine and not cell.checked then
                return false
            end
        end
    end
    return true
end

function Board:draw()
    for _, row in kalis.ipairs(self) do
        for _, cell in kalis.ipairs(row) do
            cell:draw()
        end
    end
end

return Board
