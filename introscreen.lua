IntroScreen = {
	excelsiorLogo = nil,
	new = function(self)
		o = {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	init = function(self) 
		self.excelsiorLogo = Sprite:new(excelsiorLogoImage)
	end,
	draw = function(self)
		love.graphics.setColor(255, 255, 255)
		self.excelsiorLogo:drawcenter(screenWidth / 2, screenHeight / 2, 0, 0.3)
	end
}
