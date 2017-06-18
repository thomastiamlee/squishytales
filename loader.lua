function loadResources()
	-- Sheets
	gameSheetImage = love.graphics.newImage("assets/game.png")
	logoImage = love.graphics.newImage("assets/title.png")
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
	introBgm:setVolume(0.1)
	seafloorBgm = love.audio.newSource("assets/bgm/wallpaper.mp3", "stream")
	seafloorBgm:setVolume(0.1)
end

function initGame()
	-- Background settings
	love.window.setMode(800, 480)
	love.graphics.setBackgroundColor(255, 255, 255)
	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()
end

function normalize(value)
	return value / 800 * screenWidth
end

-- For these easing functions, 
-- t - current time
-- b - start value
-- c - change in value
-- d - duration
function easeOutCubicUtility(t, b, c, d)
	t = t / d
	t = t - 1
	return c * (t * t * t + 1) + b
end