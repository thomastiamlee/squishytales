require 'loader'
require 'sprite'
require 'screen'
require 'introscreen'
require 'gamescreen'
require 'areadata'

-- Previous timestamp
prevTime = nil
elapsedTime = 0
-- Mouse / touch information
touchPressed = false

function initScreens()
	screenManager = ScreenManager:new()
	introScreen = IntroScreen:new()
	gameScreen = GameScreen:new()
	screenManager:addscreen(introScreen, "intro")
	screenManager:addscreen(gameScreen, "game")
	
	seafloorAreaData = SeafloorAreaData:new()
	
	--screenManager:transition("game", {areadata = seafloorAreaData})
	screenManager:transition("intro", {})
end

function love.load()
	loadResources()
	initGame()
	initScreens()
end

function love.update()
	-- Compute elapsed time
	currTime = love.timer.getTime()
	if prevTime == nil then
		elapsedTime = 0
		prevTime = currTime
	else
		elapsedTime = currTime - prevTime
		prevTime = currTime
	end
	
	screenManager:update()
end

function love.draw()
	screenManager:draw()
end

function love.mousepressed(x, y, button, istouch)
	screenManager:triggermousepressed(x, y)
end

function love.mousereleased(x, y, button, istouch)
	screenManager:triggermousereleased(x, y)
end

function love.mousemoved(x, y, dx, dy, istouch)
	screenManager:triggermousemoved(x, y)
end 