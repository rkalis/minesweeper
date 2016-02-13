-- The Cell table is used for every individual square on the game board.
-- A cell can contain a mine, it can be clicked, it can be checked and it can
-- be flagged. It has a size and coordinates. It also contains the number of
-- neighbouring mines.
Cell = {
    x,
    y,
    size = CELL_SIZE,
    clicked = false,
    mine = false,
    numMines = 0,
    checked = false,
    flagged = false
}

function Cell:new(x, y)
    obj = {
        x = x,
        y = y,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- If the cell isn't a mine, this function counts the amount of mines there are
-- in the adjacent cells. If there aren't any, it will call the checkNeighbours
-- function for all adajcent tiles. It checks at the start whether a tile has 
-- already been checked to avoid an infinite loop. When flagged tiles are cleared
-- in this way, the flags are properly removed, unless it is done to clear the 
-- board at the end of the game.
function Cell:checkNeighbours(index1, index2)
    if self.mine == true then return end

    -- Clears flag
    -- TODO: Cell instance shouldn't know about global game state
    if not (state == "endgame") then
        if self.flagged == true then
            self.flagged = false
            totalFlags = totalFlags - 1
        end
    end

    if self.checked == true then return end

    -- Checks the amount of mines
    for i = -1, 1 do
        for j = -1, 1 do
            if not (i == 0 and j == 0)
            and (index1 + i >= 0 and index1 + i <= NUM_ROWS - 1)
            and (index2 + j >= 0 and index2 + j <= NUM_COLS - 1) then
                if board[index1 + i][index2 + j].mine == true then
                    self.numMines = self.numMines + 1
                end
            end
        end
    end
    self.checked = true

    -- Calls the checkNeighbours function for all neighbours
    if self.numMines > 0 then return end
    for i = -1, 1 do
        for j = -1, 1 do
            if not (i == 0 and j == 0)
            and (index1 + i >= 0 and index1 + i <= NUM_ROWS - 1)
            and (index2 + j >= 0 and index2 + j <= NUM_COLS - 1)
            then
                board[index1 + i][index2 + j]:
                checkNeighbours(index1 + i, index2 + j)
            end
        end
    end
end