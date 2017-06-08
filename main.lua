function love.load()
	gameSheet = love.graphics.newImage("assets/game.png")
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	love.graphics.setBackgroundColor(255, 255, 255)
	
	squishyFrame = 0;
end

function love.update()
	squishyFrame = squishyFrame + 1
	if squishyFrame == 7 then squishyFrame = 0 end
end

function love.draw()
	quad = love.graphics.newQuad(0, 75 * squishyFrame, 75, 75, gameSheet:getWidth(), gameSheet:getHeight())
	love.graphics.draw(gameSheet, quad, screenWidth / 2, screenHeight / 2 + 15, 0, 0.75, 0.75, 37, 37)
end