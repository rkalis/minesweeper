local menu = {}

function menu:enter(previous, game)
    self.game = game
end

function menu:mousereleased(x, y, button)
    if button ~= 1 then return end
    for option, menuButton in pairs(self.game.buttons) do
        if menuButton:isClicked(x, y) then
            local minespercentage = 0
            if option == "easy" then mines_percentage = 11
            elseif option == "medium" then mines_percentage = 17
            elseif option == "hard" then mines_percentage = 23 end
            self.game.total_mines = math.ceil(
                mines_percentage / 100 * NUM_COLS * NUM_ROWS)

            self.game.difficulty = option

            self.game.buttons.easy = nil
            self.game.buttons.hard = nil

            Gamestate.switch(states.pregame, self.game)
        end
    end
end

return menu
