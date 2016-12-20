local assets = {
    graphics = {
        block = {
            [0] = love.graphics.newImage("assets/graphics/block_clicked.png"),
            love.graphics.newImage("assets/graphics/1.png"),
            love.graphics.newImage("assets/graphics/2.png"),
            love.graphics.newImage("assets/graphics/3.png"),
            love.graphics.newImage("assets/graphics/4.png"),
            love.graphics.newImage("assets/graphics/5.png"),
            love.graphics.newImage("assets/graphics/6.png"),
            love.graphics.newImage("assets/graphics/7.png"),
            love.graphics.newImage("assets/graphics/8.png"),
            unclicked = love.graphics.newImage("assets/graphics/block_unclicked.png"),
            flag = love.graphics.newImage("assets/graphics/flag.png"),
            bomb = love.graphics.newImage("assets/graphics/bomb.png"),
            bomb_clicked = love.graphics.newImage("assets/graphics/bomb_clicked.png"),
            bomb_wrong = love.graphics.newImage("assets/graphics/bomb_wrong.png")
        },
        smiley = {
            def = love.graphics.newImage("assets/graphics/smiley.png"),
            win = love.graphics.newImage("assets/graphics/smiley_win.png"),
            lose = love.graphics.newImage("assets/graphics/smiley_lose.png"),
            o = love.graphics.newImage("assets/graphics/smiley_o.png"),
            green = love.graphics.newImage("assets/graphics/smiley_green.png"),
            red = love.graphics.newImage("assets/graphics/smiley_red.png")
        }
    },
    audio = {
        win = love.audio.newSource("assets/audio/win.wav", static),
        lose = love.audio.newSource("assets/audio/bomb_explode.wav", static)
    }
}
return assets
