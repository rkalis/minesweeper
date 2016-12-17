local preGame = {}

function preGame:enter(previous)
end

function preGame:mousereleased(x, y, button, isTouch)
    cell = board:mouseCoordsToCell(x, y)
    if not cell then return end
    if button == 1 then
        placeMines(board:mouseCoordsToBoard(x, y))
        start_time = love.timer.getTime()
        state = "play"

        if not cell:click() then
            outcome = "lose"
            state = "endgame"
        end

        if checkWin() then
            state = "endgame"
        end
    end

end

function preGame:mousepressed(x, y, button, isTouch)
    cell = board:mouseCoordsToCell(x, y)
    if not cell then return end
    if button == 2 then
        cell:toggleFlag()
    end
end

function preGame:draw()
    UI:draw()
end

return preGame
