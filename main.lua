require 'loader'
require 'sprite'
require 'screen'
require 'introscreen'

-- Previous timestamp
prevTime = nil
elapsedTime = 0

function initScreens()
	screenManager = ScreenManager:new()
	introScreen = IntroScreen:new()
	screenManager:addscreen(introScreen, "intro")
	
	screenManager:transition("intro")
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
		elapsedTime = currTime
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