local preGame = {}

function preGame:enter(previous, game)
    self.game = game
end

function preGame:mousereleased(x, y, button)
    if button ~= 1 then return end

    if self.game.buttons.medium:isClicked(x, y) then
        Gamestate.switch(states.menu, self.game:reset())
        return
    end

    local cell = self.game.board:mouseToCell(x, y)
    if not cell then return end

    self.game.board:placeMines(cell, self.game.total_mines)
    self.game.start_time = love.timer.getTime()

    cell:click()

    if self.game.board:isCleared() then
        Gamestate.switch(states.endgame, self.game)
    end

    Gamestate.switch(states.game, self.game)
end

function preGame:draw()
    local mines_remaining = self.game.total_mines - self.game.total_flags
    self.game.ui:draw(mines_remaining, math.floor(self.game.score))
end

return preGame
