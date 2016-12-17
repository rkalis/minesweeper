-- require "cell"

Board = {
    start_of_board,
    cell_size
}

function Board:new(width, height, cell_size, start_of_board)
    local obj = {
        start_of_board = start_of_board,
        cell_size = cell_size
    }

    -- Set cells
    for i = 0, height - 1 do
        obj[i] = {}
        for j = 0, width - 1 do
            obj[i][j] = Cell:new(j * cell_size, i * cell_size + start_of_board)
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

function Board:mouseCoordsToCell(mouse_x, mouse_y)
    local clicked_x, clicked_y = self:mouseCoordsToBoard(mouse_x, mouse_y)
    if not clicked_x or not clicked_y then return nil end
    return board[clicked_y][clicked_x]
end

function Board:mouseCoordsToBoard(mouse_x, mouse_y)
    if mouse_y < self.start_of_board then return nil end
    local clicked_y = math.floor((mouse_y - self.start_of_board) / self.cell_size)
    local clicked_x = math.floor(mouse_x / self.cell_size)
    return clicked_x, clicked_y
end
