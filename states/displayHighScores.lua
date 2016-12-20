local displayHighScores = {}

function displayHighScores:mousereleased(x, y, button)
    if button == 1 and buttons.medium:isClicked(x, y) then
        reset()
    end
end

function displayHighScores:draw()
    ui:draw(total_mines - total_flags, math.floor(score))

    buttons.medium.smiley = outcome
    buttons.medium:draw()

    highscores:draw(difficulty)
end

return displayHighScores
