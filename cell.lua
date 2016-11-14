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
function Cell:checkNeighbours(index1, index2, clear_flags)
    -- Clears flag
    if clear_flags then
        if self.flagged then
            self.flagged = false
            total_flags = total_flags - 1
        end
    end

    if self.mine or self.checked then
        self.checked = true
        return
    end

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
                checkNeighbours(index1 + i, index2 + j, clear_flags)
            end
        end
    end
end

-- This function displays a cell depending on the state it is in.
-- If the state is clicked and it is a mine, the game is lost and the state
-- changes to endgame.
function Cell:draw()
    love.graphics.setColor(255,255,255)
    -- If it's being clicked, display the clicked sprite
    if self.checked == true then
        if self.mine == true then
            if self.clicked == true then
                love.graphics.draw(assets.graphics.block.bomb_clicked, self.x, self.y, 0, self.size / 120)
            else
                love.graphics.draw(assets.graphics.block.bomb, self.x, self.y, 0, self.size / 120)
            end
        elseif self.flagged == true then
            love.graphics.draw(assets.graphics.block.bomb_wrong, self.x, self.y, 0, self.size / 120)
        else
            love.graphics.draw(assets.graphics.block[self.numMines], self.x, self.y, 0, self.size / 120)
        end
    else
        if self.flagged == true then
            love.graphics.draw(assets.graphics.block.flag, self.x, self.y, 0, self.size / 120)
        -- TODO: This kind of breaks encapsulation
        elseif love.mouse.isDown(1) and
           (love.mouse.getX() > self.x and love.mouse.getX() < self.x + self.size) and
           (love.mouse.getY() > self.y and love.mouse.getY() < self.y + self.size) then
            love.graphics.draw(assets.graphics.block[0], self.x, self.y, 0, self.size / 120)
            buttons.medium.smiley = "o"
        else
            love.graphics.draw(assets.graphics.block.unclicked, self.x, self.y, 0, self.size / 120)
        end
    end
    love.graphics.setColor(100,100,100)
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
end
