IntroScreen = {
	excelsiorLogo = nil,
	loveLogo = nil,
	logo, nil,
	menuBg = nil,
	bgScale = nil,
	screenstate = nil,
	bgOffset = nil,
	pantime = nil,
	currpantime = nil,
	new = function(self)
		o = {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	init = function(self, data) 
		self.excelsiorLogo = Sprite:new(excelsiorLogoImage)
		self.loveLogo = Sprite:new(loveLogoImage)
		self.logo = Sprite:new(logoImage)
		self.menuBg = Sprite:new(menuBgImage)
		self.bgScale = screenWidth / (menuBgImage:getWidth() / 2)
		self.pantime = normalize(1000)
		self.bgOffset = 0
		
		self:triggerpan()
		
		love.audio.play(introBgm)
	end,
	triggerpan = function(self)
		self.screenstate = "pan"
		self.currpantime = 0
	end,
	update = function(self)
		if self.screenstate == "pan" then
			self.currpantime = self.currpantime + elapsedTime * 1000
			if self.currpantime >= self.pantime then
				self.currpantime = self.pantime
			end
			self.bgOffset = easeOutCubicUtility(self.currpantime, 0, -(menuBgImage:getHeight() * self.bgScale) + screenHeight, self.pantime)
		end
	end,
	draw = function(self)
		love.graphics.setColor(255, 255, 255)
		self.menuBg:draw(0, self.bgOffset, 0, self.bgScale)
		self.excelsiorLogo:drawcenter(screenWidth / 2 - 150, screenHeight / 2, 0, 1)
		self.loveLogo:drawcenter(screenWidth / 2 + 150, screenHeight / 2, 0, 1)
		self.logo:drawcenter(screenWidth / 2, screenHeight / 2, 0, 1)
		love.graphics.setFont(quicksandFont)
		love.graphics.printf("CREATED BY", screenWidth / 2 - 250, screenHeight / 2 - loveLogoImage:getHeight() * 0.6, 200, "center")
		love.graphics.printf("POWERED BY", screenWidth / 2 + 50, screenHeight / 2 - loveLogoImage:getHeight() * 0.6, 200, "center")
	end
}
