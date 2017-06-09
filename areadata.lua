SeafloorAreaData = {
	backgroundBackSprite = nil,
	backgroundMiddleSprite = nil,
	backgroundFrontSprite = nil,
	backOffset = 0,
	new = function(self)
		o = {
			backgroundBackSprite = Sprite:new(seafloorBackImage),
			backgroundMiddleSprite = Sprite:new(seafloorMiddleImage),
			backgroundFrontSprite = Sprite:new(seafloorFrontImage)			
		}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	drawbackground = function(self)
		self.backgroundBackSprite:draw(self.backOffset, 0, 0, screenHeight / seafloorBackImage:getHeight())
		self.backgroundMiddleSprite:draw(self.backOffset, 0, 0, screenHeight / seafloorMiddleImage:getHeight())
		self.backgroundFrontSprite:draw(self.backOffset, 0, 0, screenHeight / seafloorFrontImage:getHeight())
	end
}