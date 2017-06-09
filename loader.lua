function loadResources()
	-- Sheets
	gameSheetImage = love.graphics.newImage("assets/game.png")
	loveLogoImage = love.graphics.newImage("assets/love-bubble.png")
	excelsiorLogoImage = love.graphics.newImage("assets/excelsior-bubble.png")
	menuBgImage = love.graphics.newImage("assets/menuback.png")
	seafloorBackImage = love.graphics.newImage("assets/seafloor-back.png")
	seafloorMiddleImage = love.graphics.newImage("assets/seafloor-middle.png")
	seafloorFrontImage = love.graphics.newImage("assets/seafloor-front.png")
	-- Fonts
	quicksandFont = love.graphics.newFont("assets/quicksand.otf", 24)
	-- Audio
	introBgm = love.audio.newSource("assets/bgm/sunshine.mp3", "stream")
	introBgm:setVolume(0.05)
end

function initGame()
	-- Background settings
	love.window.setMode(800, 480)
	love.graphics.setBackgroundColor(255, 255, 255)
	-- Global variables
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
end