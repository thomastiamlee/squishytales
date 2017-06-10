GameScreen = {
	squishy = nil,
	bubble = nil,
	-- Area data (level specific information)
	areadata = nil,
	new = function(self)
		o = {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	init = function(self, data)
		self.squishy = {
			image = MSprite:new(gameSheetImage, 75, 75, 0, 0, 7, 1, 100),
			scale = screenHeight * 0.1 / 75,
			x = screenWidth / 2,
			y = screenHeight / 2,
			vx = 0,
			vy = 0,
			update = function(self)
				self.image:update()
				self.x = self.x + self.vx
				self.y = self.y + self.vy
			end,
			draw = function(self)
				self.image:drawcenter(self.x, self.y, 0, self.scale)
			end
		}
		self.bubble = {
			image = MSprite:new(gameSheetImage, 225, 225, 0, 525, 1, 1, 0),
			popimage = MSprite:new(gameSheetImage, 225, 225, 0, 750, 1, 1, 0),
			x = 0,
			y = 0,
			popduration = 75,
			currpopduration = 0,
			scale = screenHeight * 0.25 / 225,
			growscale = 0,
			growspeed = 0.03,
			status = "none",
			spawn = function(self)
				self.status = "grow"
				self.growscale = 0.25
				self.currpopduration = 0
			end,
			pop = function(self, callback)
				self.status = "pop"
				callback()
			end,
			update = function(self)
				if self.status == "grow" then
					self.growscale = self.growscale + self.growspeed					
					if self.growscale >= 1.25 then
						self:pop(function() end)
					end
				elseif self.status == "pop" then
					self.currpopduration = self.currpopduration + elapsedTime * 1000
					if self.currpopduration >= self.popduration then
						self.status = "none"
					end
				end
			end,
			draw = function(self)
				if self.status == "grow" then
					self.image:drawcenter(self.x, self.y, 0, self.scale * self.growscale)
				elseif self.status == "pop" then
					self.popimage:drawcenter(self.x, self.y, 0, self.scale * self.growscale * 1.75)
				end
			end
		}
		self.areadata = data.areadata
	end,
	update = function(self)
		self.squishy:update()
		self.bubble:update()
	end,
	draw = function(self)
		self.areadata:drawbackground()
		self.squishy:draw()
		self.bubble:draw()
	end,
	mousepressed = function(self, x, y)
		if self.bubble.status == "none" then
			self.bubble:spawn()
			self.bubble.x = x
			self.bubble.y = y
		end
	end,
	mousereleased = function(self, x, y)
		if self.bubble.status == "grow" then
			self.bubble:pop(function() end)
		end
	end,
	mousemoved = function(self, x, y)
		if self.bubble.status == "grow" then
			self.bubble.x = x
			self.bubble.y = y
		end
	end
}
