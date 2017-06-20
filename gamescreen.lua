GameScreen = {
	squishy = nil,
	bubble = nil,
	enemies = {},
	-- Area data (level specific information)
	areadata = nil,
	-- Level control
	spawntime = 5000,
	currentspawntime = 0,
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
			vx = normalize(0),
			vy = normalize(0),
			friction = normalize(0.05),
			maxpush = normalize(6),
			update = function(self)
				self.image:update()
				if self.x + self.vx >= screenWidth - 75 * self.scale / 2 then
					self.x = screenWidth - 75 * self.scale / 2
					self.vx = self.vx * -1
				elseif self.x + self.vx <= 75 * self.scale / 2 then
					self.x = 75 * self.scale / 2
					self.vx = self.vx * -1
				else
					self.x = self.x + self.vx
				end
				if self.y + self.vy >= screenHeight - 25 * self.scale / 2 then
					self.y = screenHeight - 25 * self.scale / 2
					self.vy = self.vy * -1
				elseif self.y + self.vy <= 75 * self.scale / 2 then
					self.y = 75 * self.scale / 2
					self.vy = self.vy * -1
				else
					self.y = self.y + self.vy
				end
				if self.vx == 0 then
					if self.vy > 0 then
						self.vy = math.max(self.vy - self.friction, 0)
					else
						self.vy = math.min(self.vy + self.friction, 0)
					end
				else
					local angle = math.atan(math.abs(self.vy / self.vx))
					if self.vx > 0 then
						self.vx = math.max(self.vx - math.cos(angle) * self.friction, 0)	
					else
						self.vx = math.min(self.vx + math.cos(angle) * self.friction, 0)
					end
					if self.vy > 0 then
						self.vy = math.max(self.vy - math.sin(angle) * self.friction, 0)
					else
						self.vy = math.min(self.vy + math.sin(angle) * self.friction, 0)
					end
				end
			end,
			draw = function(self)
				self.image:drawcenter(self.x, self.y, 0, self.scale)
			end,
			push = function(self, sx, sy, scale, growscale)
				local dist = math.abs(math.sqrt(math.pow(sx - self.x, 2) + math.pow(sy - self.y, 2)))
				local threshold = 160 * scale * growscale
				if dist <= threshold then
					local strength = growscale / 1.25 * self.maxpush
					if self.y == sy and self.x == sx then
					
					elseif self.x == sx then
						if self.y < sy then
							self.vy = self.vy - strength
						else
							self.vy = self.vy + strength
						end
					else	
						local angle = math.atan(math.abs(self.y - sy) / math.abs(self.x - sx))
						if self.x < sx then
							self.vx = self.vx - math.cos(angle) * strength
						else
							self.vx = self.vx + math.cos(angle) * strength
						end
						if self.y < sy then
							self.vy = self.vy - math.sin(angle) * strength
						else
							self.vy = self.vy + math.sin(angle) * strength
						end
					end
				end
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
			growspeed = 0.025,
			status = "none",
			spawn = function(self)
				self.status = "grow"
				self.growscale = 0.5
				self.currpopduration = 0
			end,
			pop = function(self, callback)
				popSfx:setVolume(math.min(1, self.growscale))
				popSfx:play()
				self.status = "pop"
				callback()
			end,
			update = function(self, popcallback)
				if self.status == "grow" then
					self.growscale = self.growscale + self.growspeed					
					if self.growscale >= 1.25 then
						self:pop(popcallback)
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
		self.areadata:scroll(0)
		
		love.audio.play(self.areadata.music)		
	end,	
	handlecollisions = function(self)
		local sl = self.squishy.x - 32 * self.squishy.scale
		local sr = self.squishy.x + 32 * self.squishy.scale
		local su = self.squishy.y - 37 * self.squishy.scale
		local sd = self.squishy.y + 2 * self.squishy.scale
		local i = 1
		while i <= table.getn(self.enemies) do
			if self.enemies[i].alive == false then
				table.remove(self.enemies, i)
				i = i - 1
			else 
				local hitboxes = self.enemies[i].hitbox
				local enemyScale = self.enemies[i].scale
				local enemyX = self.enemies[i].x - self.enemies[i].sprite.width / 2 * self.enemies[i].scale
				local enemyY = self.enemies[i].y - self.enemies[i].sprite.height / 2 * self.enemies[i].scale
				for j = 1, table.getn(hitboxes), 1 do
					local x, y, w, h = hitboxes[j]:getViewport()
					local hl = x * enemyScale + enemyX
					local hr = x * enemyScale + enemyX + w * enemyScale
					local hu = y * enemyScale + enemyY
					local hd = y * enemyScale + enemyY + h * enemyScale
					if not(sr < hl or sl > hr or su > hd or sd < hu) then
						-- collision
					end
				end
				
				self.enemies[i].sprite:update()
				self.enemies[i]:update()
			end
			i = i + 1
		end
	end,
	updateenemyspawn = function(self)
		self.currentspawntime = self.currentspawntime + elapsedTime * 1000
		if self.currentspawntime >= self.spawntime then
			local grouper = Wildlife:new("grouper")
			grouper:spawn()
			table.insert(self.enemies, grouper)
			self.currentspawntime = 0
		end
	end,
	update = function(self)
		self.areadata:update()
		self.squishy:update()
		self.bubble:update(function() self.squishy:push(self.bubble.x, self.bubble.y, self.bubble.scale, self.bubble.growscale) end)
		self:handlecollisions()
		self:updateenemyspawn()
	end,
	draw = function(self)
		self.areadata:drawbackground()
		for i = 1, table.getn(self.enemies), 1 do
			self.enemies[i].sprite:drawcenter(self.enemies[i].x, self.enemies[i].y, 0, self.enemies[i].scale)
		end
		self.squishy:draw()
		self.bubble:draw()
		self:drawdebug()
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
			self.bubble:pop(function() self.squishy:push(self.bubble.x, self.bubble.y, self.bubble.scale, self.bubble.growscale) end)
		end
	end,
	mousemoved = function(self, x, y)
		if self.bubble.status == "grow" then
			self.bubble.x = x
			self.bubble.y = y
		end
	end,
	drawdebug = function(self)
		local sl = self.squishy.x - 32 * self.squishy.scale
		local sr = self.squishy.x + 32 * self.squishy.scale
		local su = self.squishy.y - 37 * self.squishy.scale
		local sd = self.squishy.y + 3 * self.squishy.scale
		love.graphics.setColor(255, 0, 0, 100)
		love.graphics.polygon('fill', sl, su, sr, su, sr, sd, sl, sd)
		for i = 1, table.getn(self.enemies), 1 do
			local hitboxes = self.enemies[i].hitbox
			local enemyX = self.enemies[i].x - self.enemies[i].sprite.width / 2 * self.enemies[i].scale
			local enemyY = self.enemies[i].y - self.enemies[i].sprite.height / 2 * self.enemies[i].scale
			local enemyScale = self.enemies[i].scale
			for j = 1, table.getn(hitboxes), 1 do
				local x, y, w, h = hitboxes[j]:getViewport()
				local hl = x * enemyScale + enemyX
				local hr = x * enemyScale + enemyX + w * enemyScale
				local hu = y * enemyScale + enemyY
				local hd = y * enemyScale + enemyY + h * enemyScale
				love.graphics.setColor(255, 0, 0, 100)
				love.graphics.polygon('fill', hl, hu, hr, hu, hr, hd, hl, hd)
			end
		end
	end
}
