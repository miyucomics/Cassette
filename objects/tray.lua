local Colors = require("core/colors")
local Cursor = require("core/cursor")
local Slot = require("objects/slot")
local Tray = require("libraries/classic"):extend()

function Tray:new ()
	self.width = screenWidth / 2
	self.height = screenHeight / 2
	self.x = love.math.random(25, screenWidth - self.width - 25)
	self.y = love.math.random(25, screenHeight - self.height - 25)
	self.dx = love.math.random(-50, 50) / 10
	self.dy = 5
	self.slots = {}
	for y = 0, 3 do
		for x = 0, 4 do
			table.insert(self.slots, Slot((x + 1) * self.width / 6 + self.x, (y + 1) * self.height / 5 + self.y, 27, 5, nil))
		end
	end
end

function Tray:update (deltaTime)
	self.x = self.x + self.dx * deltaTime
	self.y = self.y + self.dy * deltaTime
	for _, slot in pairs(self.slots) do
		slot.x = slot.x + self.dx * deltaTime
		slot.y = slot.y + self.dy * deltaTime
	end
	if self.x + self.width > screenWidth then
		self.x = screenWidth - self.width
		self.dx = -self.dx
	end
	if self.y + self.height > screenHeight then
		self.y = screenHeight - self.height
		self.dy = -self.dy
	end
	if self.x < 0 then
		self.x = 0
		self.dx = -self.dx
	end
	if self.y < 0 then
		self.y = 0
		self.dy = -self.dy
	end
end

function Tray:draw ()
	love.graphics.setColor(Colors.Mantle)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(Colors.Crust)
	love.graphics.rectangle("fill", self.x, self.y + self.height, self.width, 5)
	for _, slot in pairs(self.slots) do
		slot:draw()
	end
end

return Tray
