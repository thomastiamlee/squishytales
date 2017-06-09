GameScreen = {
	squishy = nil,
	bubble = nil,
	bubbleLoc = nil,
	bubblestatus = nil,
	areadata = nil,
	new = function(self)
		o = {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	init = function(self, data)
		self.squishy = MSprite:new(gameSheetImage, 75, 75, 0, 0, 7, 1, 100)
		self.bubble = MSprite:new(gameSheetImage, 225, 225, 0, 525, 1, 1, 0)
		self.areadata = data.areadata
		self.bubbledata = false
	end,
	update = function(self)
		self.squishy:update()
	end,
	draw = function(self)
		self.areadata:drawbackground()
		self.squishy:drawcenter(screenWidth / 2, screenHeight / 2, 0, 0.75)
		if self.bubbledata then
			self.bubble:drawcenter(self.bubbleLoc.x, self.bubbleLoc.y)
		end
	end,
	mousepressed = function(self, x, y)
		if self.bubbledata == false then
			self.bubbledata = true
			self.bubbleLoc = {x = x, y = y}
		end
	end,
	mousereleased = function(self, x, y)
		if self.bubbledata == true then
			self.bubbledata = false
		end
	end,
	mousemoved = function(self, x, y)
		if self.bubbledata == true then
			self.bubbleLoc = {x = x, y = y}
		end
	end
}
