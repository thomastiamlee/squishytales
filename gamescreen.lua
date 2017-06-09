GameScreen = {
	squishy = nil,
	areadata = nil,
	new = function(self)
		o = {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	init = function(self, data)
		self.squishy = MSprite:new(gameSheetImage, 75, 75, 0, 0, 7, 1, 100)
		self.areadata = data.areadata
	end,
	update = function(self)
		self.squishy:update()
	end,
	draw = function(self)
		self.areadata:drawbackground()
		self.squishy:drawcenter(screenWidth / 2, screenHeight / 2, 0, 0.75)
	end
}
