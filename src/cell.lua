local kalis = require "lib.kalis"
local Cell = {}

function Cell:new(x, y, size)
    local obj = {
        x = x,
        y = y,
        size = size,
        clicked = false,
        mine = false,
        checked = false,
        flagged = false,
        neighbouring_mines = 0,
        neighbours = {}
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
function Cell:checkNeighbours(clear_flags)
    local flags_cleared = 0
    -- Clears flag
    if clear_flags then
        if self.flagged then
            self.flagged = false
            flags_cleared = flags_cleared + 1
        end
    end

    if self.mine or self.checked then
        self.checked = true
        return flags_cleared
    end

    -- Checks the amount of mines
    for _, neighbour in ipairs(self.neighbours) do
        if neighbour.mine then
            self.neighbouring_mines = self.neighbouring_mines + 1
        end
    end
    self.checked = true

    -- Calls the checkNeighbours function for all neighbours
    if self.neighbouring_mines > 0 then return flags_cleared end
    for _, neighbour in ipairs(self.neighbours) do
        flags_cleared = flags_cleared + neighbour:checkNeighbours(clear_flags)
    end
    return flags_cleared
end

function Cell:toggleFlag()
    if self.checked or self.clicked then
        return 0
    end
    if not self.flagged then
        self.flagged = true
        return 1
    elseif self.flagged then
        self.flagged = false
        return -1
    end
end

function Cell:click()
    if not self.flagged then
        self.clicked = true
        return self:checkNeighbours(true)
    end
    return nil
end

function Cell:equals(other)
    return self.x == other.x and self.y == other.y
end

function Cell:isNeighbour(other)
    for _, cell in ipairs(self.neighbours) do
        if cell:equals(other) then return true end
    end
    return false
end


function Cell:drawSprite(sprite)
    love.graphics.draw(sprite, self.x, self.y, 0, self.size / 120)
end

-- This function displays a cell depending on the state it is in.
-- If the state is clicked and it is a mine, the game is lost and the state
-- changes to endgame.
function Cell:draw()
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
               kalis.is_clicked(self, love.mouse.getX(), love.mouse.getY()) then
            self:drawSprite(assets.graphics.block[0])
        else
            self:drawSprite(assets.graphics.block.unclicked)
        end
    end
    love.graphics.setColor(100,100,100)
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
    love.graphics.setColor(255,255,255)
end

return Cell
