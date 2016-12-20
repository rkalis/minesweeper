local enterHighScores = {}

function enterHighScores:mousereleased(x, y, button)
    if button == 1 and buttons.medium:isClicked(x, y) then
        reset()
    end
end

function enterHighScores:keypressed(key)
    if input:len() < 10 then
        if key and key:match('^[%w]$') then
            input = input .. key:upper()
        end
    end
    if key == "backspace" then
        input = input:sub(1, -2)
    elseif key == "return" then
        if input ~= "" then
            local name = input
            highscores:addScore(difficulty, name, score)
        end
        Gamestate.switch(states.displayHighScores)
    end
end

function enterHighScores:draw()
    ui:draw(total_mines - total_flags, math.floor(score))

    buttons.medium.smiley = outcome
    buttons.medium:draw()

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
    love.graphics.printf(input, WINDOW_WIDTH / 2 - 49,
                         WINDOW_HEIGHT / 2 - 10, 98, "left")
    love.graphics.setColor(255,255,255)
end

return enterHighScores
