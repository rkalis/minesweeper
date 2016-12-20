local preGame = {}

function preGame:mousereleased(x, y, button)
    if button ~= 1 then return end

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
        Gamestate.switch(states.endgame)
    end

    Gamestate.switch(states.game)
end

function preGame:draw()
    ui:draw(total_mines - total_flags, math.floor(score))
end

return preGame
