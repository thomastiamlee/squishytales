require 'loader'
require 'sprite'
require 'screen'
require 'introscreen'

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
	screenManager:update()
end

function love.draw()
	screenManager:draw()
end