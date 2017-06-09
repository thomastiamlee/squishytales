function loadResources()
	-- Sheets
	gameSheetImage = love.graphics.newImage("assets/game.png")
	loveLogoImage = love.graphics.newImage("assets/love.png")
	excelsiorLogoImage = love.graphics.newImage("assets/excelsior.png")
	-- Fonts
	quicksandFont = love.graphics.newFont("assets/quicksand.otf", 24)
end

function initGame()
	-- Global variables
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
	-- Background settings
	love.graphics.setBackgroundColor(255, 255, 255)
end