function love.load()
	gameSheet = love.graphics.newImage("assets/game.png")
	love.graphics.setBackgroundColor(255, 255, 255)
end

function love.draw()
	
	love.graphics.draw(gameSheet, 0, 0)
end