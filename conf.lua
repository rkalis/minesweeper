function love.conf(t)
    -- Global variables
    CELL_SIZE = 40
    NUM_ROWS = 15
    NUM_COLS = 10
    STATS_HEIGHT = 100
    WINDOW_WIDTH = CELL_SIZE * NUM_COLS
    WINDOW_HEIGHT = CELL_SIZE * NUM_ROWS + STATS_HEIGHT

    -- Configuration settings
    t.identity = "LuaSweeper"
    t.version = "0.10.0"
    t.console = false

    t.window.title          = "Minesweeper Xxtreme Relo4ded 2.0: Retribution"
    t.window.width          = WINDOW_WIDTH
    t.window.height         = WINDOW_HEIGHT
    t.window.borderless     = false
    t.window.resizable      = false
    t.window.minwidth       = 1
    t.window.minheight      = 1
    t.window.fullscreen     = false
    t.window.fullscreentype = "desktop"
    t.window.vsync          = true
    t.window.msaa           = 0
    t.window.display        = 1
    t.window.highdpi        = false
    t.window.x              = nil
    t.window.y              = nil

    t.modules.audio    = true
    t.modules.event    = true
    t.modules.graphics = true
    t.modules.image    = true
    t.modules.joystick = false
    t.modules.keyboard = true
    t.modules.math     = false
    t.modules.mouse    = true
    t.modules.physics  = false
    t.modules.sound    = true
    t.modules.system   = true
    t.modules.timer    = true
    t.modules.window   = true
    t.modules.thread   = true
end
