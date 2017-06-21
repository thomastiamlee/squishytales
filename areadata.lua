Trash = {
	x = nil,
	y = nil,
	sprite = nil,
	electricsprite = nil,
	scale = nil,
	hitbox = nil,
	update = nil,
	rotation = nil,
	rotationspeed = 2,
	alive = nil,
	state = nil,
	refpost = nil,
	idletime = 2000,
	currentidletime = 0,
	falldistance = 0,
	falltime = 4500,
	currentfalltime = 0,
	newrandom = function(self)
		randomizer = math.floor(math.random(0, 6))
		scale = normalize(0.6)
		o = {
			falldistance = normalize(125),
			sprite = MSprite:new(gameSheetImage, 75, 75, 150, 75 * randomizer, 1, 1, 0),
			electricsprite = MSprite:new(gameSheetImage, 75, 75, 225, 525, 6, 1, 100),
			scale = scale,
			hitbox = love.graphics.newQuad(5, 5, 65, 65, screenWidth, screenHeight),
			rotation = 0,
			alive = true,
			spawn = function(self) 
				self.x = math.random(normalize(75), screenWidth - normalize(75))
				self.y = -(75 *  scale)
				self.state = "fall"
				self.refpos = self.y
				self.currentfalltime = 0
			end,
			update = function(self)
				local degrees = math.deg(self.rotation)
				degrees = (degrees + self.rotationspeed) % 360
				self.rotation = math.rad(degrees)
				if self.state == "fall" then
					self.currentfalltime = self.currentfalltime + elapsedTime * 1000
					if self.currentfalltime > self.falltime then
						self.currentfalltime = self.falltime
					end
					self.y = easeOutCubicUtility(self.currentfalltime, self.refpos, self.falldistance, self.falltime)
					if self.currentfalltime == self.falltime then
						self.state = "idle"
						self.refpos = self.y
						self.currentidletime = 0
					end
				elseif self.state == "idle" then
					if self.y > screenHeight + 75 * self.scale then
						self.alive = false
					end
					self.currentidletime = self.currentidletime + elapsedTime * 1000
					if self.currentidletime >= self.idletime then
						self.state = "fall"
						self.currentfalltime = 0
					end
				elseif self.state == "electric" then
					self.electricsprite:update()
					if self.electricsprite.currentFrame == 6 then
						self.alive = false
					end
				end
			end,
			triggerelectric = function(self) 
				self.state = "electric"
			end,
			draw = function(self)
				self.sprite:draw(self.x, self.y, self.rotation, self.scale, 37, 37)
				if self.state == "electric" then
					self.electricsprite:draw(self.x, self.y, 0, self.scale, 37, 37)
				end
			end
		}
		setmetatable(o, self)
		self.__index = self
		return o
	end
}

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
				range = normalize(100),
				refpoint = nil,
				rangetime = 2400,
				currentrangetime = 0,
				direction = "down",
				sprite = MSprite:new(gameSheetImage, 150, 150, 300, 0, 4, 1, 310),
				scale = scale,
				hitbox = {
					love.graphics.newQuad(15, 40, 60, 60, screenWidth, screenHeight),
					love.graphics.newQuad(80, 60, 55, 40, screenWidth, screenHeight)
				},
				alive = true,
				spawn = function(self)
					self.direction = "down"
					self.currentrangetime = 0
					self.refpoint = math.random(40 * scale, (screenHeight - 40 * scale) - self.range)
					self.x = screenWidth + 75 * scale
					self.y = self.refpoint
				end,
				update = function(self)
					self.currentrangetime = self.currentrangetime + elapsedTime * 1000
					if self.direction == "down" then
						if self.currentrangetime > self.rangetime then
							self.currentrangetime = self.rangetime
						end
						self.y = easeInOutSineUtility(self.currentrangetime, self.refpoint, self.range, self.rangetime)
						if self.currentrangetime == self.rangetime then
							self.direction = "up"
							self.currentrangetime = 0
						end
					elseif self.direction == "up" then
						if self.currentrangetime > self.rangetime then
							self.currentrangetime = self.rangetime
						end
						self.y = easeInOutSineUtility(self.currentrangetime, self.refpoint + self.range, -self.range, self.rangetime)
						if self.currentrangetime == self.rangetime then
							self.direction = "down"
							self.currentrangetime = 0
						end
					end
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