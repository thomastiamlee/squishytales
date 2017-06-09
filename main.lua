require 'loader'
require 'sprite'

function love.load()
	loadResources()
	initGame()
	
	a  = Sprite:new(excelsiorLogo)
end

function love.draw()
	a:drawcenter(screenWidth / 2, screenHeight / 2, 0, 0.3)
end