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
	end,
	draw = function(self)
		love.graphics.setColor(255, 255, 255)
		self.menuBg:draw(0, 0, 0, self.bgScale)
		self.excelsiorLogo:drawcenter(screenWidth / 2 - 150, screenHeight / 2, 0, 0.3)
		self.loveLogo:drawcenter(screenWidth / 2 + 150, screenHeight / 2, 0, 0.5)
	end
}
