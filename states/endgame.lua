local endgame = {}

function endgame:enter(previous, game)
    self.time = 0
    self.game = game
end

function endgame:update(dt)
    if self.time == 0 then
        love.audio.play(assets.audio[self.game.outcome])
        self.game.board:clear()
    end
    self.time = self.time + dt

    if self.game.outcome == "win" and self.time >= 3 then
        Gamestate.switch(states.enterHighScores, self.game)
    end
end

function endgame:draw()
    local mines_remaining = self.game.total_mines - self.game.total_flags
    self.game.ui:draw(mines_remaining, math.floor(self.game.score))

    self.game.ui.buttons.medium.smiley = self.game.outcome
    self.game.ui.buttons.medium:draw()
end

function endgame:mousereleased(x, y, button)
    if button == 1 and self.game.ui.buttons.medium:isClicked(x, y) then
        Gamestate.switch(states.menu, self.game:reset())
    end
end

return endgame
