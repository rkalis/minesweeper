Cell = {}

function Cell:new(x, y)
    obj = {
        x = x,
        y = y,
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Cell:checkNeighbours()
end

Button = {}

function Button:new(x, y)
    obj = {
        x = x,
        y = y,
        width = 60,
        height = 60
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- love.load() is called at the start of the game.
-- It can be used to setup the game.
function love.load()
    -- Seeds the math.random() function, and calibrates it with a few
    -- calibration calls.
    math.randomseed(os.time())
    math.random(); math.random(); math.random(); math.random();
    love.graphics.setBackgroundColor(170,170,170)
end

-- love.draw() is called every timestep. It can be used for game logic
-- and time-based calculations as a dt parameter is passed, which signifies
-- the time that has passed since the last timestep
function love.update(dt)
end

-- love.mousereleased is called whenever the mouse is released,
-- with the parameters specifying the button and position
function love.mousereleased(x, y, button)
end

-- love.keypressed is called whenever a key is pressed, with the
-- `key` parameter specifying which key
function love.keypressed(key)
end

-- love.draw() is called every timestep. It is used to draw to the window
function love.draw()
end
