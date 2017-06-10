SeafloorAreaData = {
	music = nil,
	backgroundBackSprite = nil,
	backgroundMiddleSprite = nil,
	backgroundFrontSprite = nil,
	backOffset = 0,
	scrollspeed = nil,
	status = "stop",
	new = function(self)
		o = {
			backgroundBackSprite = Sprite:new(seafloorBackImage),
			backgroundMiddleSprite = Sprite:new(seafloorMiddleImage),
			backgroundFrontSprite = Sprite:new(seafloorFrontImage),
			scrollspeed = normalize(0.25),
			music = seafloorBgm
		}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	scroll = function(self, direction) -- 0 for right, 1 for left
		if direction == 0 then
			self.status = "scrollright"
		elseif direction == 1 then
			self.status = "scrollleft"
		end
	end,
	update = function(self)
		if self.status == "scrollright" then
			if self.backOffset - self.scrollspeed < -seafloorFrontImage:getWidth() + screenWidth then
				self.status = "scrollleft"
			else
				self.backOffset = self.backOffset - self.scrollspeed
			end
		elseif self.status == "scrollleft" then
			if self.backOffset + self.scrollspeed > 0 then
				self.status = "scrollright"
			else
				self.backOffset = self.backOffset + self.scrollspeed
			end
		end
	end,
	drawbackground = function(self)
		self.backgroundBackSprite:draw(self.backOffset * 0.5, 0, 0, screenHeight / seafloorBackImage:getHeight())
		--self.backgroundBackSprite:draw(self.backOffset + seafloorBackImage:getWidth(), 0, 0, screenHeight / seafloorBackImage:getHeight())
		
		self.backgroundMiddleSprite:draw(self.backOffset * 0.85, 0, 0, screenHeight / seafloorMiddleImage:getHeight())
		--self.backgroundMiddleSprite:draw(self.backOffset + seafloorMiddleImage:getWidth(), 0, 0, screenHeight / seafloorMiddleImage:getHeight())
		
		self.backgroundFrontSprite:draw(self.backOffset, 0, 0, screenHeight / seafloorFrontImage:getHeight())
		--self.backgroundFrontSprite:draw(self.backOffset + seafloorFrontImage:getWidth(), 0, 0, screenHeight / seafloorFrontImage:getHeight())
	end
}