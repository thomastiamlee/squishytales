IntroScreen = {
	excelsiorLogo = nil,
	loveLogo = nil,
	menuBg = nil,
	bgScale = nil,
	new = function(self)
		o = {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	init = function(self) 
		self.excelsiorLogo = Sprite:new(excelsiorLogoImage)
		self.loveLogo = Sprite:new(loveLogoImage)
		self.menuBg = Sprite:new(menuBgImage)
		self.bgScale = screenWidth / (menuBgImage:getWidth() / 2)
		 
		love.audio.play(introBgm)
	end,
	draw = function(self)
		love.graphics.setColor(255, 255, 255)
		self.menuBg:draw(0, 0, 0, self.bgScale)
		self.excelsiorLogo:drawcenter(screenWidth / 2 - 150, screenHeight / 2, 0, 1)
		self.loveLogo:drawcenter(screenWidth / 2 + 150, screenHeight / 2, 0, 1)
		love.graphics.setFont(quicksandFont)
		love.graphics.printf("CREATED BY", screenWidth / 2 - 250, screenHeight / 2 - loveLogoImage:getHeight() * 0.6, 200, "center")
		love.graphics.printf("POWERED BY", screenWidth / 2 + 50, screenHeight / 2 - loveLogoImage:getHeight() * 0.6, 200, "center")
	end
}
