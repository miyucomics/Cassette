local Colors = require("core/colors")
local Gamestate = {
	gamestate = "win",
	states = {
		title = require("core/title"),
		game = require("core/game"),
		win = require("core/win"),
		lose = require("core/lose")
	}
}

function Gamestate.setGamestate (state)
	Gamestate.gamestate = state
end

function Gamestate.start ()
	if Gamestate.states[Gamestate.gamestate].start then
		Gamestate.states[Gamestate.gamestate].start()
	end
end

function Gamestate.update (deltaTime)
	if Gamestate.states[Gamestate.gamestate].update then
		Gamestate.states[Gamestate.gamestate].update(deltaTime)
	end
end

function Gamestate.draw ()
	if Gamestate.states[Gamestate.gamestate].draw then
		Gamestate.states[Gamestate.gamestate].draw()
	end
end

function Gamestate.mousepressed (x, y)
	if Gamestate.states[Gamestate.gamestate].mousepressed then
		Gamestate.states[Gamestate.gamestate].mousepressed(x, y)
	end
end

function Gamestate.mousereleased (x, y)
	if Gamestate.states[Gamestate.gamestate].mousereleased then
		Gamestate.states[Gamestate.gamestate].mousereleased(x, y)
	end
end

return Gamestate
