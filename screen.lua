ScreenManager = {
	screens = {},
	activeScreen = nil,
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
	transition = function(self, name)
		if self.activeScreen then
		
		else
			self.activeScreen = self:getscreen(name)
		end
	end,
	draw = function(self)
		if self.activeScreen then
			self.activeScreen:draw()
		end
	end
}
