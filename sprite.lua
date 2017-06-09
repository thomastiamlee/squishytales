Sprite = {
	image = nil,
	new = function(self, image)
		o = {image = image}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	draw = function(self, x, y, rotation, scale)
		rotation = rotation or 0
		scale = scale or 1
		love.graphics.draw(self.image, x, y, rotation, scale, scale)
	end,
	drawcenter = function(self, x, y, rotation, scale)
		rotation = rotation or 0
		scale = scale or 1
		love.graphics.draw(self.image, x - (self.image):getWidth() * scale / 2, y - (self.image):getHeight() * scale / 2, rotation, scale, scale)
	end
}