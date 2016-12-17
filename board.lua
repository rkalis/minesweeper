require "cell"

Board = {

}

function Board:new(width, height, cell_size, start_of_board)
    local obj = {

    }

    for i = 0, height - 1 do
        obj[i] = {}
        for j = 0, width - 1 do
            obj[i][j] = Cell:new(j * cell_size, i * cell_size + start_of_board)
        end
    end
    setmetatable(obj, self)
    self.__index = self
    return obj
end
