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
    neighbouring_mines = 0,
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
function Cell:checkNeighbours(cell_x, cell_y, clear_flags)
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
            and (cell_x + i >= 0 and cell_x + i <= NUM_ROWS - 1)
            and (cell_y + j >= 0 and cell_y + j <= NUM_COLS - 1) then
                if board[cell_x + i][cell_y + j].mine then
                    self.neighbouring_mines = self.neighbouring_mines + 1
                end
            end
        end
    end
    self.checked = true

    -- Calls the checkNeighbours function for all neighbours
    if self.neighbouring_mines > 0 then return end
    for i = -1, 1 do
        for j = -1, 1 do
            if not (i == 0 and j == 0)
            and (cell_x + i >= 0 and cell_x + i <= NUM_ROWS - 1)
            and (cell_y + j >= 0 and cell_y + j <= NUM_COLS - 1) then
                board[cell_x + i][cell_y + j]:
                checkNeighbours(cell_x + i, cell_y + j, clear_flags)
            end
        end
    end
end

function Cell:drawSprite(sprite)
    love.graphics.draw(sprite, self.x, self.y, 0, self.size / 120)
end

-- This function displays a cell depending on the state it is in.
-- If the state is clicked and it is a mine, the game is lost and the state
-- changes to endgame.
function Cell:draw()
    love.graphics.setColor(255,255,255)
    -- If it's being clicked, display the clicked sprite
    if self.checked then
        if self.mine then
            if self.clicked then
                self:drawSprite(assets.graphics.block.bomb_clicked)
            else
                self:drawSprite(assets.graphics.block.bomb)
            end
        elseif self.flagged then
            self:drawSprite(assets.graphics.block.bomb_wrong)
        else
            self:drawSprite(assets.graphics.block[self.neighbouring_mines])
        end
    else
        if self.flagged then
            self:drawSprite(assets.graphics.block.flag)
        elseif love.mouse.isDown(1) and
           (love.mouse.getX() > self.x and love.mouse.getX() < self.x + self.size) and
           (love.mouse.getY() > self.y and love.mouse.getY() < self.y + self.size) then
            self:drawSprite(assets.graphics.block[0])
            -- TODO: This kind of breaks encapsulation
            buttons.medium.smiley = "o"
        else
            self:drawSprite(assets.graphics.block.unclicked)
        end
    end
    love.graphics.setColor(100,100,100)
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
end
