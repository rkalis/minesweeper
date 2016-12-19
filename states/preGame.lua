local preGame = {}

function preGame:enter(previous)
end

function preGame:mousereleased(x, y, button, isTouch)
    local cell = board:mouseToCell(x, y)
    if not cell then return end
    if button == 1 then
        board:placeMines(cell, total_mines)
        start_time = love.timer.getTime()

        cell:click()

        if checkWin() then
            state = "endgame"
            Gamestate.switch(states.placeholder)
        end

        state = "play"
        Gamestate.switch(states.placeholder)
    end

end

function preGame:mousepressed(x, y, button, isTouch)
    -- local cell = board:mouseToCell(x, y)
    -- if not cell then return end
    -- if button == 2 then
    --     cell:toggleFlag()
    -- end
end

function preGame:draw()
    ui:draw(total_mines - total_flags, math.floor(score))
end

return preGame
