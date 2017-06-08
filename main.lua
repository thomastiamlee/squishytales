function love.load()
	gameSheet = love.graphics.newImage("assets/game.png")
	loveLogo = love.graphics.newImage("assets/love.png")
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	love.graphics.setBackgroundColor(255, 255, 255)
	
	quicksandFont = love.graphics.newFont("assets/quicksand.otf", 24)
	
	squishyFrame = 0;
end

function love.update()
	squishyFrame = squishyFrame + 1
	if squishyFrame == 7 then squishyFrame = 0 end
end

function love.draw()
	love.graphics.setColor(255,255,255)
	quad = love.graphics.newQuad(0, 75 * squishyFrame, 75, 75, gameSheet:getWidth(), gameSheet:getHeight())
	--love.graphics.draw(gameSheet, quad, screenWidth / 2, screenHeight / 2 - 15, 0, 0.75, 0.75, 37, 37)
	love.graphics.draw(loveLogo, screenWidth / 2 - loveLogo:getWidth() * 0.45 / 2, screenHeight / 2 - 40, 0, 0.45, 0.45)	
	love.graphics.setColor(0,0,0)
	love.graphics.setFont(quicksandFont)
	love.graphics.printf("powered by", 0, screenHeight / 2 - 80, screenWidth, "center")
end