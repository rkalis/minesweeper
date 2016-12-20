local endgame = {}

function endgame:enter()
    self.time = 0
end

function endgame:update(dt)
    if self.time == 0 then
        love.audio.play(assets.audio[outcome])
    end
    self.time = self.time + dt

    for _, row in utils.ipairs(board) do
        for _, cell in utils.ipairs(row) do
            cell:checkNeighbours(false)
        end
    end

    if outcome == "win" and self.time >= 3 then
        Gamestate.switch(states.enterHighScores)
    end
end

function endgame:draw()
    ui:draw(total_mines - total_flags, math.floor(score))
    buttons.medium.smiley = outcome
    buttons.medium:draw()
end

function endgame:mousereleased(x, y, button)
    if button == 1 and buttons.medium:isClicked(x, y) then
        reset()
    end
end

return endgame
