function love.conf(t)
    -- Global variables. Use these in your program.
    CELL_SIZE = 40
    NUM_ROWS = 15
    NUM_COLS = 10
    STATS_HEIGHT = 100
    WINDOW_WIDTH = CELL_SIZE * NUM_COLS
    WINDOW_HEIGHT = CELL_SIZE * NUM_ROWS + STATS_HEIGHT
    
    -- Configuration settings for the game.
    t.window.height = WINDOW_HEIGHT
    t.window.width = WINDOW_WIDTH
    t.window.resizable = false
end
