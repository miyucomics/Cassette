love.graphics.setLineStyle("rough")
love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setFont(love.graphics.newFont("assets/m5x7.ttf", 16))

scalar = 2
screenWidth = love.graphics.getWidth() / scalar
screenHeight = love.graphics.getHeight() / scalar

local music = love.audio.newSource("assets/sounds/music.mp3", "static")
music:setVolume(0.25)
music:setLooping(true)
music:play()

Manager = require("core/manager")
Manager:register(Manager)
Manager:register(require("core/gamestate"))
Manager:register(require("core/cursor"))
Manager:emit("start")

local Post = require("libraries/post")

function love.update (deltaTime)
	Manager:emit("update", deltaTime)
end

function love.draw ()
	Post:push()
	Manager:emit("draw")
	Post:pop()
end

function love.mousepressed (x, y, button, istouch, presses)
	Manager:emit("mousepressed", x / scalar, y / scalar, button)
end

function love.mousemoved (x, y, dx, dy, istouch)
	Manager:emit("mousemoved", x / scalar, y / scalar, dx / scalar, dy / scalar)
end

function love.mousereleased (x, y, button, istouch, presses)
	Manager:emit("mousereleased", x / scalar, y / scalar)
end
