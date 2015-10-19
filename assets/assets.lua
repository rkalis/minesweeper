local assets = {
	graphics = {
		block = {
			love.graphics.newImage("1.png"),
			love.graphics.newImage("2.png"),
			love.graphics.newImage("3.png"),
			love.graphics.newImage("4.png"),
			love.graphics.newImage("5.png"),
			love.graphics.newImage("6.png"),
			love.graphics.newImage("7.png"),
			love.graphics.newImage("8.png"),
			unclicked    = love.graphics.newImage("block_unclicked.png"),
			clicked      = love.graphics.newImage("block_clicked.png"),
			flag         = love.graphics.newImage("flag.png"),
			bomb         = love.graphics.newImage("bomb.png"),
			bomb_clicked = love.graphics.newImage("bomb_clicked.png"),
			bomb_wrong   = love.graphics.newImage("bomb_wrong.png")
		}

		smiley = {
			def  = love.graphics.newImage("smiley.png"),
			win  = love.graphics.newImage("smiley_win.png"),
			lose = love.graphics.newImage("smiley_lose.png"),
			o    = love.graphics.newImage("smiley_o.png")
		}
	},
	audio = {
		win  = love.audio.newSource("win.wav", static),
		lose = love.audio.newSource("bomb_explode.wav", static)
	}

}