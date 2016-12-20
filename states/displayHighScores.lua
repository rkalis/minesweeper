local displayHighScores = {}

function displayHighScores:enter(previous, game)
    self.game = game
end

function displayHighScores:mousereleased(x, y, button)
    if button == 1 and self.game.ui.buttons.medium:isClicked(x, y) then
        Gamestate.switch(states.menu, self.game:reset())
    end
end

function displayHighScores:draw()
    local mines_remaining = self.game.total_mines - self.game.total_flags
    self.game.ui:draw(mines_remaining, math.floor(self.game.score))

    self.game.ui.buttons.medium.smiley = self.game.outcome
    self.game.ui.buttons.medium:draw()

    self.game.highscores:draw(self.game.difficulty)
end

return displayHighScores
