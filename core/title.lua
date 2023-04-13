local Colors = require("core/colors")
local Manager = require("core/manager")
local Title = {}

local background = love.graphics.newImage("assets/title.png")

function Title.draw ()
	love.graphics.setColor(0.5, 0.5, 0.5, 1)
	love.graphics.draw(background)
	love.graphics.setColor(Colors.Text, 1)
	love.graphics.printf("A Hitchhiker's Guide to Cassette Sorting in Space", 10, 10, screenWidth / 2 - 10, "center", 0, 2, 2)
	love.graphics.printf("You are returning to Earth after a space exploration voyage.", 10, 80, screenWidth - 20, "center")
	love.graphics.printf("Unfortunately, your ship hit some interstellar turbulence and your precious cassette tapes containing your collected data are mixed up and floating about.", 10, 100, screenWidth - 20, "center")
	love.graphics.printf("Luckily, you wrote down the sum of the rows and columns on a little note.", 10, 150, screenWidth - 20, "center")
	love.graphics.printf("Place them back in the right spots!", 10, 180, screenWidth - 20, "center")
	love.graphics.printf("Press your mouse to start!", 10, 200, screenWidth - 20, "center")
end

function Title.mousepressed (x, y)
	Manager:emit("setGamestate", "game")
	Manager:emit("start")
end

return Title
