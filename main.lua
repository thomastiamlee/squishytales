function love.load()
	gameSheet = love.graphics.newImage("assets/game.png")
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	love.graphics.setBackgroundColor(255, 255, 255)
end

function love.draw()
	quad = love.graphics.newQuad(0, 0, 75, 75, gameSheet:getWidth(), gameSheet:getHeight())
	love.graphics.draw(gameSheet, quad, screenWidth / 2, screenHeight / 2 + 15, 0, 0.75, 0.75, 37, 37)
end