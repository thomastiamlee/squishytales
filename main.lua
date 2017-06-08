function love.load()
	gameSheet = love.graphics.newImage("assets/game.png")
end

function love.draw()
	love.graphics.draw(gameSheet, 0, 0)
end