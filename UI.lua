UI = {}
function UI:draw()
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(font)

    love.graphics.printf("Mines remaining: " .. (total_mines - total_flags),
                         WINDOW_WIDTH / 2 + 35, STATS_HEIGHT / 2,
                         WINDOW_WIDTH / 2 - 40, "center")

    love.graphics.print("Time: " .. (math.floor(score)),
                        WINDOW_WIDTH * 1/5 - 20, STATS_HEIGHT / 2)
end

return UI
