local preGame = {}

function preGame:mousereleased(x, y, button, isTouch)
    if button == 1 then
        if buttons.medium:isClicked(x, y) then
            reset()
            return
        end

        local cell = board:mouseToCell(x, y)
        if not cell then return end

        board:placeMines(cell, total_mines)
        start_time = love.timer.getTime()

        cell:click()

        if checkWin() then
            state = "endgame"
            Gamestate.switch(states.placeholder)
        end

        -- state = "play"
        Gamestate.switch(states.game)
    end

end

function preGame:draw()
    ui:draw(total_mines - total_flags, math.floor(score))
end

return preGame
