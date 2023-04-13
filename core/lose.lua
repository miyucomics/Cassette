local Colors = require("core/colors")
local Lose = {}

local background = love.graphics.newImage("assets/lose.png")

function Lose.draw ()
	love.graphics.setColor(0.5, 0.5, 0.5, 1)
	love.graphics.draw(background)
	love.graphics.setColor(Colors.Text, 1)
	love.graphics.printf("A Hitchhiker's Guide to Cassette Sorting in Space", 10, 10, screenWidth / 2 - 10, "center", 0, 2, 2)
	love.graphics.printf("You lost!", 10, 80, screenWidth - 20, "center")
	love.graphics.printf("Press Enter to try again!", 10, 180, screenWidth - 20, "center")
end

function Lose.mousepressed (x, y)
	Manager:emit("setGamestate", "game")
	Manager:emit("start")
end

return Lose
