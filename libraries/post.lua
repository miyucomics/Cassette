local Colors = require("core/colors")
local Post = {}
local screenCanvas = love.graphics.newCanvas(screenWidth, screenHeight)

function Post:push ()
	love.graphics.setCanvas(screenCanvas)
	love.graphics.clear()
end

function Post:pop ()
	love.graphics.setCanvas()
	love.graphics.setColor(Colors.Reset)
	love.graphics.draw(screenCanvas, 0, 0, 0, 2, 2)
end

return Post
