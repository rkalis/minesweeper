local menu = {}

function menu:enter(previous, game)
    self.game = game
end

function menu:mousereleased(x, y, button)
    if button ~= 1 then return end
    for option, menuButton in pairs(self.game.ui.buttons) do
        if menuButton:isClicked(x, y) then
            local ratios = {
                easy = 0.11,
                medium = 0.17,
                hard = 0.23
            }
            
            local board_size = self.game.board.width * self.game.board.height
            self.game.total_mines = math.ceil(ratios[option] * board_size)

            self.game.difficulty = option

            self.game.ui.buttons.easy = nil
            self.game.ui.buttons.hard = nil

            Gamestate.switch(states.pregame, self.game)
        end
    end
end

return menu
