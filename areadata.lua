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
		elseif name == "brownturtle" then
			local scale = normalize(0.75)
			o = {
				name = "brownturtle",
				range = normalize(200),
				refpoint = nil,
				rangetime = 3600,
				currentrangetime = 0,
				direction = "down",
				sprite = MSprite:new(gameSheetImage, 150, 150, 1425, 1200, 4, 1, 310),
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
		elseif name == "blackturtle" then
			local scale = normalize(0.75)
			o = {
				name = "brownturtle",
				range = normalize(300),
				refpoint = nil,
				rangetime = 3000,
				currentrangetime = 0,
				direction = "down",
				sprite = MSprite:new(gameSheetImage, 150, 150, 1275, 1200, 4, 1, 310),
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
					self.x = self.x - normalize(1.5)
					if self.x < -75 * scale then
						self.alive = false
					end
				end
			}
		elseif name == "redoctopus" then
			local scale = normalize(0.75)
			o = {
				name = "redoctopus",
				status = nil,
				range = screenHeight * .6,
				movetime = 3000,
				currentmovetime = 0,
				waittime = 2500,
				currentwaittime = 0,
				originheight = nil,
				sprite = MSprite:new(gameSheetImage, 150, 150, 825, 0, 4, 1, 340),
				scale = scale,
				hitbox = {
					love.graphics.newQuad(38, 13, 66, 86, screenWidth, screenHeight),
					love.graphics.newQuad(31, 96, 91, 40, screenWidth, screenHeight)
				},
				alive = true,
				spawn = function(self)
					self.x = math.random(75 * scale + normalize(150), screenWidth - 75 * scale - normalize(150))
					self.status = "rise"
					self.currentmovetime = 0
					self.currenttime = 0
					self.y = screenHeight + 150 * scale / 2
					self.originheight = self.y
				end,
				update = function(self)
					if self.status == "rise" then
						self.currentmovetime = self.currentmovetime + elapsedTime * 1000
						if self.currentmovetime > self.movetime then
							self.currentmovetime = self.movetime
						end
						self.y = linearUtility(self.currentmovetime, self.originheight, -self.range, self.movetime)
						if self.currentmovetime == self.movetime then
							self.status = "wait"
							self.currentwaittime = 0
						end
					elseif self.status == "wait" then
						self.currentwaittime = self.currentwaittime + elapsedTime * 1000
						if self.currentwaittime > self.waittime then
							self.currentwaittime = self.waittime
						end
						if self.currentwaittime == self.waittime then
							self.status = "fall"
							self.currentmovetime = 0
						end
					elseif self.status == "fall" then
						self.currentmovetime = self.currentmovetime + elapsedTime * 1000
						if self.currentmovetime > self.movetime then
							self.currentmovetime = self.movetime
						end
						self.y = linearUtility(self.currentmovetime, self.originheight - self.range, self.range, self.movetime)
						if self.currentmovetime == self.movetime then
							self.alive = false
						end
					end
				end
			}
		elseif name == "blueoctopus" then
			local scale = normalize(0.75)
			o = {
				name = "blueoctopus",
				status = nil,
				range = nil,
				movetime = nil,
				currentmovetime = 0,
				waittime = 2500,
				currentwaittime = 0,
				originheight = nil,
				sprite = MSprite:new(gameSheetImage, 150, 150, 675, 900, 4, 1, 340),
				scale = scale,
				hitbox = {
					love.graphics.newQuad(38, 13, 66, 86, screenWidth, screenHeight),
					love.graphics.newQuad(31, 96, 91, 40, screenWidth, screenHeight)
				},
				alive = true,
				spawn = function(self)
					self.x = math.random(75 * scale + normalize(150), screenWidth - 75 * scale - normalize(150))
					self.status = "rise"
					self.range = math.random(normalize(150), screenHeight - normalize(150 * scale))
					self.movetime = math.random(1750, 3250)
					self.currentmovetime = 0
					self.currenttime = 0
					self.y = screenHeight + 150 * scale / 2
					self.originheight = self.y
				end,
				update = function(self)
					if self.status == "rise" then
						self.currentmovetime = self.currentmovetime + elapsedTime * 1000
						if self.currentmovetime > self.movetime then
							self.currentmovetime = self.movetime
						end
						self.y = linearUtility(self.currentmovetime, self.originheight, -self.range, self.movetime)
						if self.currentmovetime == self.movetime then
							self.status = "wait"
							self.currentwaittime = 0
						end
					elseif self.status == "wait" then
						self.currentwaittime = self.currentwaittime + elapsedTime * 1000
						if self.currentwaittime > self.waittime then
							self.currentwaittime = self.waittime
						end
						if self.currentwaittime == self.waittime then
							self.status = "fall"
							self.currentmovetime = 0
						end
					elseif self.status == "fall" then
						self.currentmovetime = self.currentmovetime + elapsedTime * 1000
						if self.currentmovetime > self.movetime then
							self.currentmovetime = self.movetime
						end
						self.y = linearUtility(self.currentmovetime, self.originheight - self.range, self.range, self.movetime)
						if self.currentmovetime == self.movetime then
							self.alive = false
						end
					end
				end
			}
		elseif name == "swordfish" then
			local scale = normalize(0.75)
			o = {
				name = "swordfish",
				sprite = MSprite:new(gameSheetImage, 225, 75, 975, 0, 4, 1, 280),
				status = nil,
				origin = nil,
				entertime = 200,
				currententertime = 0,
				waittime = 1200,
				currentwaittime = 0,
				chargetime = 450,
				currentchargetime = 0,
				attacktime = 1500,
				currentattacktime = 0,
				scale = scale,
				hitbox = {
					love.graphics.newQuad(2, 31, 90, 13, screenWidth, screenHeight),
					love.graphics.newQuad(90, 6, 115, 57, screenWidth, screenHeight)
				},
				alive = true,
				spawn = function(self)
					self.x = screenWidth + 225 * scale / 2
					self.y = math.random(normalize(40), screenHeight - normalize(40))
					self.status = "enter"
					self.currententertime = 0
					self.origin = self.x
				end,
				update = function(self)
					if self.status == "enter" then
						self.currententertime = self.currententertime + elapsedTime * 1000
						if self.currententertime > self.entertime then
							self.currententertime = self.entertime
						end
						self.x = linearUtility(self.currententertime, self.origin, -normalize(120 * scale), self.entertime)
						if self.currententertime == self.entertime then
							self.status = "wait"
							self.currentwaittime = 0
						end
					elseif self.status == "wait" then
						self.currentwaittime = self.currentwaittime + elapsedTime * 1000
						if self.currentwaittime > self.waittime then
							self.currentwaittime = self.waittime
						end	
						if self.currentwaittime == self.waittime then
							self.status = "charge"
							self.currentchargetime = 0
							self.origin = self.x
						end
					elseif self.status == "charge" then
						self.currentchargetime = self.currentchargetime + elapsedTime * 1000
						if self.currentchargetime > self.chargetime then
							self.currentchargetime = self.chargetime
						end
						self.x = easeInOutSineUtility(self.currentchargetime, self.origin, normalize(70 * scale), self.chargetime)
						if self.currentchargetime == self.chargetime then
							self.status = "attack"
							self.currentattacktime = 0
							self.origin = self.x
						end
					elseif self.status == "attack" then
						self.currentattacktime = self.currentattacktime + elapsedTime * 1000
						if self.currentattacktime > self.attacktime then
							self.currentattacktime = self.attacktime
						end
						self.x = easeInOutSineUtility(self.currentattacktime, self.origin, -(225 * scale) - self.origin, self.attacktime)
						if self.currentattacktime == self.attacktime then
							self.alive = false
						end
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