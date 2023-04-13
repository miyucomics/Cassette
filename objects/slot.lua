local Colors = require("core/colors")
local Slot = require("libraries/classic"):extend()
local Cursor = require("core/cursor")

local cassetteInsertSound = love.audio.newSource("assets/sounds/cassette_insert.mp3", "static")
local cassetteEjectSound = love.audio.newSource("assets/sounds/cassette_eject.mp3", "static")

function Slot:new (x, y, width, height, data)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.data = data
end

function Slot:draw ()
	love.graphics.setColor(Colors.Text)
	love.graphics.rectangle("fill", self.x - self.width / 2 - 1, self.y - self.height / 2 - 1, self.width + 2, self.height + 2)
	love.graphics.setColor(Colors.Mantle)
	love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
	if self.data then
		love.graphics.setColor(Colors.Text)
		love.graphics.rectangle("fill", self.x - self.width / 2 + 1, self.y - self.height / 2 + 1, self.width - 2, self.height - 2)
		love.graphics.print(self.data, self.x, self.y)
	end
end

function Slot:insert (x, y)
	self.data = Cursor.data
	cassetteInsertSound:play()
	Cursor.data = nil
end

function Slot:eject (x, y)
	Cursor.data = self.data
	cassetteEjectSound:play()
	self.data = nil
end

return Slot
