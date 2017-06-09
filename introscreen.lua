IntroScreen = {
	excelsiorLogo = nil,
	new = function(self)
		excelsiorLogo = Sprite:new(excelsiorLogoImage)
		o = {excelsiorLogo = excelsiorLogo}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	draw = function(self)
		excelsiorLogo:drawcenter(screenWidth / 2, screenHeight / 2, 0, 0.3)
	end
}
