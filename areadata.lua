Wildlife = {
	name = nil,
	x = nil,
	y = nil,
	sprite = nil,
	scale = nil,
	hitbox = nil,
	spawn = nil,
	update = nil,
	alive = nil,
	new = function(self, name)
		if name == "grouper" then
			local scale = normalize(0.75)
			o = {
				name = "grouper",
				sprite = MSprite:new(gameSheetImage, 150, 75, 675, 0, 4, 1, 250),
				scale = scale,
				hitbox = {
					love.graphics.newQuad(55, 5, 60, 70, screenWidth, screenHeight),
					love.graphics.newQuad(20, 20, 130, 45, screenWidth, screenHeight)
				},
				alive = true,
				spawn = function(self)
					self.x = screenWidth + 75 * scale
					self.y = math.random(40 * scale, screenHeight - 40 * scale)
				end,
				update = function(self)
					self.x = self.x - normalize(1)
					if self.x < -75 * scale then
						self.alive = false
					end
				end
			}
		elseif name == "greenturtle" then
			local scale = normalize(0.75)
			o = {
				name = "greenturtle",
				sprite = MSprite:new(gameSheetImage, 150, 150, 300, 0, 4, 1, 310),
				scale = scale,
				hitbox = {
					love.graphics.newQuad(15, 40, 60, 60, screenWidth, screenHeight),
					love.graphics.newQuad(80, 60, 55, 40, screenWidth, screenHeight)
				},
				alive = true,
				spawn = function(self)
					self.x = screenWidth + 75 * scale
					self.y = math.random(40 * scale, screenHeight - 40 * scale)
				end,
				update = function(self)
					self.x = self.x - normalize(1)
					if self.x < -75 * scale then
						self.alive = false
					end
				end
			}
		end
		setmetatable(o, self)
		self.__index = self
		return o
	end
}

SeafloorAreaData = {
	music = nil,
	backgroundBackSprite = nil,
	backgroundMiddleSprite = nil,
	backgroundFrontSprite = nil,
	wildlife = nil,
	backOffset = 0,
	scrollspeed = nil,
	scale = nil,
	status = "stop",
	new = function(self)
		o = {
			backgroundBackSprite = Sprite:new(seafloorBackImage),
			backgroundMiddleSprite = Sprite:new(seafloorMiddleImage),
			backgroundFrontSprite = Sprite:new(seafloorFrontImage),
			scrollspeed = normalize(0.25),
			music = seafloorBgm,
			scale = screenHeight / seafloorMiddleImage:getHeight(),
			wildlife = {"grouper"}
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
			if self.backOffset - self.scrollspeed < -seafloorFrontImage:getWidth() * self.scale + screenWidth then
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
		self.backgroundBackSprite:draw(self.backOffset * 0.5, 0, 0, self.scale)
		--self.backgroundBackSprite:draw(self.backOffset + seafloorBackImage:getWidth(), 0, 0, screenHeight / seafloorBackImage:getHeight())
		
		self.backgroundMiddleSprite:draw(self.backOffset * 0.85, 0, 0, self.scale)
		--self.backgroundMiddleSprite:draw(self.backOffset + seafloorMiddleImage:getWidth(), 0, 0, screenHeight / seafloorMiddleImage:getHeight())
		
		self.backgroundFrontSprite:draw(self.backOffset, 0, 0, self.scale)
		--self.backgroundFrontSprite:draw(self.backOffset + seafloorFrontImage:getWidth(), 0, 0, screenHeight / seafloorFrontImage:getHeight())
		love.graphics.print(self.backOffset, 10, 10)
		
	end
}