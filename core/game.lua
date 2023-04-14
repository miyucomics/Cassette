local Colors = require("core/colors")
local Cursor = require("core/cursor")
local Cassette = require("objects/cassette")
local Tray = require("objects/tray")
local Manager = require("core/manager")
local Game = {
	cassettes = {},
	tray = Tray(),
	numbers = {},
	rowSums = {},
	columnSums = {},
	slottedIn = 0
}

local background = love.graphics.newImage("assets/background.png")

function Game.start ()
	grid = {}
	for i = 1, 4 do
		grid[i] = {}
		for j = 1, 5 do
			number = love.math.random(0, 9)
			table.insert(Game.numbers, number)
			grid[i][j] = number
		end
	end

	for i = 1, 4 do
		local sum = 0
		for j = 1, 5 do
			sum = sum + grid[i][j]
		end
		table.insert(Game.rowSums, sum)
	end

	for j = 1, 5 do
		local sum = 0
		for i = 1, 4 do
			sum = sum + grid[i][j]
		end
		table.insert(Game.columnSums, sum)
	end

	for _, number in pairs(Game.numbers) do
		table.insert(Game.cassettes, Cassette(love.math.random() * (screenWidth - 25) + 12.5, love.math.random() * (screenHeight - 25) + 12.5, love.math.random() * 10 - 5, love.math.random() * 10 - 5, love.math.random() * 10 - 5, love.math.random() * 2 - 1, number))
	end
end

function Game.update (deltaTime)
	Game.tray:update(deltaTime)
	for _, cassette in pairs(Game.cassettes) do
		cassette:update(deltaTime)
	end
end

function Game.draw ()
	love.graphics.setColor(0.5, 0.5, 0.5, 1)
	love.graphics.draw(background)
	Game.tray:draw()
	for _, cassette in pairs(Game.cassettes) do
		cassette:draw()
	end
	for _, rowSum in pairs(Game.rowSums) do
		love.graphics.print("x  x  x  x  x  " .. tostring(rowSum), 10, _ * 10)
	end
	love.graphics.print(Game.columnSums[1] .. " " .. Game.columnSums[2] .. " " .. Game.columnSums[3] .. " " .. Game.columnSums[4] .. " " .. Game.columnSums[5], 10, 50)
end

function Game.mousepressed (x, y)
	for _, cassette in pairs(Game.cassettes) do
		if Cursor.x > cassette.x and math.sqrt((Cursor.x - cassette.x)^2 + (Cursor.y - cassette.y)^2) < 25 then
			Cursor.data = cassette.data
			Cursor.rotation = cassette.rotation
			Cursor.da = cassette.da
			table.remove(Game.cassettes, _)
			return
		end
	end

	for _, slot in pairs(Game.tray.slots) do
		if slot.data and Cursor.x > slot.x - slot.width / 2 - 3 and Cursor.x < slot.x - slot.width / 2 + slot.width + 6 and Cursor.y > slot.y - slot.height / 2 - 3 and Cursor.y < slot.y - slot.height / 2 + slot.height + 6 then
			slot:eject(x, y)
			Game.slottedIn = Game.slottedIn - 1
		end
	end
end

function Game.mousereleased (x, y)
	if Cursor.data then
		placedInSlot = false
		for _, slot in pairs(Game.tray.slots) do
			if not slot.data and Cursor.x > slot.x - slot.width / 2 - 3 and Cursor.x < slot.x - slot.width / 2 + slot.width + 6 and Cursor.y > slot.y - slot.height / 2 - 3 and Cursor.y < slot.y - slot.height / 2 + slot.height + 6 then
				slot:insert(x, y)
				placedInSlot = true
				Game.slottedIn = Game.slottedIn + 1
				if Game.slottedIn == 20 then
					Game.check()
				end
			end
		end
		if not placedInSlot then
			table.insert(Game.cassettes, Cassette(x - 25 / 2, y - 15 / 2, Cursor.dx * 15, Cursor.dy * 15, Cursor.rotation, love.math.random() * 1 - 0.5, Cursor.data))
			Cursor.data = nil
		end
	end
end

function tablesEqual (table1, table2)
	for key, value in pairs(table1) do
		if value ~= table2[key] then
			return false
		end
	end

	return true
end

function Game.check ()
	numbers = {}
	for _, slot in pairs(Game.tray.slots) do
		table.insert(numbers, slot.data)
	end

	local grid = {}
	local index = 1
	for i = 1, 4 do
		grid[i] = {}
		for j = 1, 5 do
			grid[i][j] = numbers[index]
			index = index + 1
		end
	end

	newRows = {}
	newCols = {}

	for i = 1, 4 do
		local sum = 0
		for j = 1, 5 do
			sum = sum + grid[i][j]
		end
		table.insert(newRows, sum)
	end

	for j = 1, 5 do
		local sum = 0
		for i = 1, 4 do
			sum = sum + grid[i][j]
		end
		table.insert(newCols, sum)
	end

	

	if tablesEqual(Game.rowSums, newRows) and tablesEqual(Game.columnSums, newCols) then
		Manager:emit("setGamestate", "win")
	else
		Manager:emit("setGamestate", "lose")
	end
	Game.numbers = {}
	Game.rowSums = {}
	Game.columnSums = {}
	Game.slottedIn = 0
	for _, slot in pairs(Game.tray.slots) do
		slot.data = nil
	end
end

return Game
