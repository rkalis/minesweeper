local game = {}

function game:enter(previous)
end

function game:update(dt)
    score = score + dt
end

function game:mousereleased(x, y, button)
    if button == 1 then
        if buttons.medium:isClicked(x, y) then
            reset()
            return
        end

        local cell = board:mouseToCell(x, y)
        if not cell then return end

        if cell:click() and cell.mine then
            outcome = "lose"
            Gamestate.switch(states.endgame)
        end

        if checkWin() then
            Gamestate.switch(states.endgame)
        end
    end

end

function game:mousepressed(x, y, button)
    if button == 2 then
        local cell = board:mouseToCell(x, y)
        if not cell then return end
        cell:toggleFlag()
    end
end

function game:draw()
    ui:draw(total_mines - total_flags, math.floor(score))
end

return game
