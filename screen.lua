ScreenManager = {
	screens = {},
	activeScreen = nil,
	fadestate = "none",
	fadealpha = 255,
	new = function(self)
		o = {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	addscreen = function(self, screen, name)
		table.insert(self.screens, {screen = screen, name = name})
	end,
	getscreen = function(self, name)
		for i = 1, table.getn(self.screens), 1 do
			if name == self.screens[i].name then
				return self.screens[i].screen
			end
		end
		return nil
	end,
	transition = function(self, name, data)
		if self.activeScreen then
		
		else
			self.activeScreen = self:getscreen(name)			
			if self.activeScreen.init then
				self.activeScreen:init(data)
				self:triggerfadein()
			end
		end
	end,
	update = function(self)
		-- Update fade
		if self.fadestate == "in" then
			self.fadealpha = self.fadealpha - 10
			if self.fadealpha <= 0 then
				self.fadestate = "none"
				self.fadealpha = 0
			end
		elseif self.fadestate == "out" then
			self.fadealpha = self.fadealpha + 10
			if self.fadealpha >= 255 then
				self.fadestate = "none"
				self.fadealpha = 255
			end
		end
				
		-- Update screen
		if self.activeScreen then
			if self.activeScreen.update then
				self.activeScreen:update()
			end
		end
	end,
	draw = function(self)
		if self.activeScreen then
			if self.activeScreen.draw then
				self.activeScreen:draw()
			end
		end
		self:drawfade()
	end,
	drawfade = function(self)
		love.graphics.setColor(0, 0, 0, self.fadealpha)
		love.graphics.polygon("fill", 0, 0, screenWidth, 0, screenWidth, screenHeight, 0, screenHeight)
	end,
	triggerfadein = function(self)
		self.fadealpha = 255
		self.fadestate = "in"
	end,
	triggerfadeout = function(self)
		self.fadealpha = 0
		self.fadestate = "out"
	end
}
