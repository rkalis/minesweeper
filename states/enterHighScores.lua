local enterHighScores = {}

function enterHighScores:enter(previous, game)
    self.game = game
    self.input = ""
end

function enterHighScores:mousereleased(x, y, button)
    if button == 1 and self.game.ui.buttons.medium:isClicked(x, y) then
        Gamestate.switch(states.menu, self.game:reset())
    end
end

function enterHighScores:keypressed(key)
    if self.input:len() < 10 then
        if key and key:match('^[%w]$') then
            self.input = self.input .. key:upper()
        end
    end
    if key == "backspace" then
        self.input = self.input:sub(1, -2)
    elseif key == "return" then
        if self.input ~= "" then
            local difficulty = self.game.difficulty
            local name = self.input
            local score = self.game.score
            self.game.highscores:addScore(difficulty, name, score)
        end
        Gamestate.switch(states.displayHighScores, self.game)
    end
end

function enterHighScores:draw()
    local mines_remaining = self.game.total_mines - self.game.total_flags
    self.game.ui:draw(mines_remaining, math.floor(self.game.score))

    self.game.ui.buttons.medium.smiley = self.game.outcome
    self.game.ui.buttons.medium:draw()

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line", WINDOW_WIDTH / 2 - 100,
                            WINDOW_HEIGHT / 2 - 50, 200, 100)
    love.graphics.setColor(200,200,200)
    love.graphics.rectangle("fill", WINDOW_WIDTH / 2 - 100,
                            WINDOW_HEIGHT / 2 - 50, 200, 100)
    love.graphics.setColor(0,0,0)
    love.graphics.printf("YOUR NAME: ", WINDOW_WIDTH / 2 - 50,
                         WINDOW_HEIGHT / 2 - 30, 100, "center")
    love.graphics.rectangle("line", WINDOW_WIDTH / 2 - 50,
                            WINDOW_HEIGHT / 2 - 10, 100, 20)
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("fill", WINDOW_WIDTH / 2 - 50,
                            WINDOW_HEIGHT / 2 - 10, 100, 20)
    love.graphics.setColor(0,0,0)
    love.graphics.printf(self.input, WINDOW_WIDTH / 2 - 49,
                         WINDOW_HEIGHT / 2 - 10, 98, "left")
    love.graphics.setColor(255,255,255)
end

return enterHighScores
