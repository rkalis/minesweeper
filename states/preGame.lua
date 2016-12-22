local pregame = {}

function pregame:enter(previous, game)
    self.game = game
end

function pregame:mousereleased(x, y, button)
    if button ~= 1 then return end

    if self.game.ui.buttons.medium:isClicked(x, y) then
        Gamestate.switch(states.menu, self.game:reset())
        return
    end

    local cell = self.game.board:mouseToCell(x, y)
    if not cell then return end

    self.game:start(cell)

    Gamestate.switch(states.game, self.game, x, y)
end

function pregame:draw()
    local mines_remaining = self.game.total_mines - self.game.total_flags
    self.game.ui:draw(mines_remaining, math.floor(self.game.score))
end

return pregame
