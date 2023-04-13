local Colors = require("core/colors")
local Cursor = require("core/cursor")
local Cassette = require("libraries/classic"):extend()

function Cassette:new (x, y, dx, dy, rotation, da, data)
	self.x = x
	self.y = y
	self.dx = dx
	self.dy = dy
	self.rotation = rotation
	self.da = da
	self.data = data
	self.width = 25
	self.height = 15
end

function Cassette:update (deltaTime)
	self.x = self.x + self.dx * deltaTime
	self.y = self.y + self.dy * deltaTime
	self.rotation = self.rotation + self.da * deltaTime
	if self.x < -25 then
		self.x = screenWidth + 25
	end
	if self.y < -25 then
		self.y = screenHeight + 25
	end
	if self.x > screenWidth + 25 then
		self.x = -25
	end
	if self.y > screenHeight + 25 then
		self.y = -25
	end
end

function Cassette:draw ()
	for i = 0, 3, 1 do
		love.graphics.push()
		love.graphics.translate(self.x, self.y - i)
		love.graphics.rotate(self.rotation)
		if i == 3 then
			love.graphics.setColor(Colors.Subtext0)
			love.graphics.rectangle("fill", -self.width / 2, -self.height / 2, self.width, self.height)
			love.graphics.setColor(Colors.Surface1)
			love.graphics.rectangle("fill", -self.width / 2 + 2, -self.height / 2 + 2, self.width - 4, self.height - 4)
			love.graphics.setColor(Colors.Text)
			love.graphics.print(self.data, -4, -8)
		else
			love.graphics.setColor(Colors.Surface2)
			love.graphics.rectangle("fill", -self.width / 2, -self.height / 2, self.width, self.height)
		end
		love.graphics.pop()
	end
	love.graphics.setColor(Colors.Text)
	love.graphics.rectangle("line", self.x, self.y, 5, 5)
	love.graphics.rectangle("fill", self.x + 2, self.y + 2, 1, 1)
end

return Cassette
