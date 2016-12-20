local game = {}

function game:enter(previous, game)
    self.game = game
end

function game:update(dt)
    self.game.score = self.game.score + dt
end

function game:mousereleased(x, y, button)
    if button ~= 1 then return end

    if self.game.ui.buttons.medium:isClicked(x, y) then
        Gamestate.switch(states.menu, self.game:reset())
        return
    end

    local cell = self.game.board:mouseToCell(x, y)
    if not cell then return end

    local flags_cleared = cell:click()
    if flags_cleared then
        self.game.total_flags = self.game.total_flags - flags_cleared

        if cell.mine then
            self.game.outcome = "lose"
            Gamestate.switch(states.endgame, self.game)
        end
    end

    if self.game.board:isCleared() then
        Gamestate.switch(states.endgame, self.game)
    end
end

function game:mousepressed(x, y, button)
    if button ~= 2 then return end

    local cell = self.game.board:mouseToCell(x, y)
    if not cell then return end
    self.game.total_flags = self.game.total_flags + cell:toggleFlag()
end

function game:draw()
    local mines_remaining = self.game.total_mines - self.game.total_flags
    self.game.ui:draw(mines_remaining, math.floor(self.game.score))
end

return game
