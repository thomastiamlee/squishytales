IntroScreen = {
	excelsiorLogo = nil,
	loveLogo = nil,
	logo, nil,
	logoScale = nil,
	logoScalePop = nil,
	logoGrowTime = 500,
	logoShrinkTime = 500,
	currpoptime = 0,
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
		self.pantime = 1750
		self.bgOffset = 0
		self.logoScale = 0
		self.logoScalePop = normalize(1.25)
		
		self:triggerpan()
		
		love.audio.play(introBgm)
	end,
	triggerpan = function(self)
		self.screenstate = "pan"
		self.currpantime = 0
	end,
	triggerlogopop = function(self)
		self.screenstate = "popgrow"
		self.currpoptime = 0
	end,
	update = function(self)
		if self.screenstate == "pan" then
			self.currpantime = self.currpantime + elapsedTime * 1000
			if self.currpantime >= self.pantime then
				self.currpantime = self.pantime
				self:triggerlogopop()
			end
			self.bgOffset = easeOutCubicUtility(self.currpantime, 0, -(menuBgImage:getHeight() * self.bgScale) + screenHeight, self.pantime)
		elseif self.screenstate == "popgrow" then
			self.currpoptime = self.currpoptime + elapsedTime * 1000
			if self.currpoptime >= self.logoGrowTime then
				self.currpoptime = self.logoGrowTime
				self.logoScale = easeOutCubicUtility(self.currpoptime, 0, self.logoScalePop, self.logoGrowTime)
				self.screenstate = "popshrink"
				self.currpoptime = 0
			else
				self.logoScale = easeOutCubicUtility(self.currpoptime, 0, self.logoScalePop, self.logoGrowTime)
			end
		elseif self.screenstate == "popshrink" then
			self.currpoptime = self.currpoptime + elapsedTime * 1000
			if self.currpoptime >= self.logoShrinkTime then
				self.currpoptime = self.logoShrinkTime
				self.logoScale = easeOutCubicUtility(self.currpoptime, self.logoScalePop, normalize(1) - self.logoScalePop, self.logoShrinkTime)
				self.screenstate = "active"
				self.currpoptime = 0
			else
				self.logoScale = easeOutCubicUtility(self.currpoptime, self.logoScalePop, normalize(1) - self.logoScalePop, self.logoShrinkTime)
			end
		end
	end,
	draw = function(self)
		love.graphics.setColor(255, 255, 255)
		self.menuBg:draw(0, self.bgOffset, 0, self.bgScale)
		self.excelsiorLogo:drawcenter(screenWidth / 2 - 150, screenHeight / 2, 0, 1)
		self.loveLogo:drawcenter(screenWidth / 2 + 150, screenHeight / 2, 0, 1)
		self.logo:drawcenter(screenWidth / 2, screenHeight / 2, 0, self.logoScale)
		love.graphics.setFont(quicksandFont)
		love.graphics.printf("CREATED BY", screenWidth / 2 - 250, screenHeight / 2 - loveLogoImage:getHeight() * 0.6, 200, "center")
		love.graphics.printf("POWERED BY", screenWidth / 2 + 50, screenHeight / 2 - loveLogoImage:getHeight() * 0.6, 200, "center")
	end
}
