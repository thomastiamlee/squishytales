function loadResources()
	-- Sheets
	gameSheetImage = love.graphics.newImage("assets/game.png")
	loveLogoImage = love.graphics.newImage("assets/love-bubble.png")
	excelsiorLogoImage = love.graphics.newImage("assets/excelsior-bubble.png")
	menuBgImage = love.graphics.newImage("assets/menuback.png")
	-- Fonts
	quicksandFont = love.graphics.newFont("assets/quicksand.otf", 24)
end

function initGame()
	-- Background settings
	love.window.setMode(800, 480)
	love.graphics.setBackgroundColor(255, 255, 255)
	-- Global variables
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
end