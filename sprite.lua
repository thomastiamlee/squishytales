Sprite = {
	image = nil,
	new = function(self, image)
		o = {image = image}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	draw = function(self, x, y, rotation, scale)
		love.graphics.setColor(255, 255, 255)
		rotation = rotation or 0
		scale = scale or 1
		love.graphics.draw(self.image, x, y, rotation, scale, scale)
	end,
	drawcenter = function(self, x, y, rotation, scale)
		love.graphics.setColor(255, 255, 255)
		rotation = rotation or 0
		scale = scale or 1
		love.graphics.draw(self.image, x - (self.image):getWidth() * scale / 2, y - (self.image):getHeight() * scale / 2, rotation, scale, scale)
	end
}

MSprite = {
	image = nil,
	width = nil,
	height = nil,
	frames = {},
	currentFrame = 1,
	speed = nil,
	currentTime = 0,
	new = function(self, image, width, height, startX, startY, numRows, numCols, speed)
		resFrames = {}
		origStartX = startX
		for i = 1, numRows, 1 do
			startX = origStartX
			for j = 1, numCols, 1 do
				newQuad = love.graphics.newQuad(startX, startY, width, height, image:getWidth(), image:getHeight())
				table.insert(resFrames, newQuad)
				startX = startX + width
			end
			startY = startY + height
		end
		
		o = {image = image, frames = resFrames, speed = speed, width = width, height = height}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	update = function(self)
		self.currentTime = self.currentTime + elapsedTime
		if self.currentTime * 1000 >= self.speed then
			self.currentTime = 0
			self.currentFrame = self.currentFrame + 1
			if self.currentFrame > table.getn(self.frames) then
				self.currentFrame = 1
			end
		end
	end,
	draw = function(self, x, y, rotation, scale)
		love.graphics.setColor(255, 255, 255)
		rotation = rotation or 0
		scale = scale or 1
		love.graphics.draw(self.image, self.frames[self.currentFrame], x, y, rotation, scale, scale)
	end,
	drawcenter = function(self, x, y, rotation, scale)
		love.graphics.setColor(255, 255, 255)
		rotation = rotation or 0
		scale = scale or 1
		love.graphics.draw(self.image, self.frames[self.currentFrame], x - self.width * scale / 2, y - self.height * scale / 2, rotation, scale, scale)
	end
}