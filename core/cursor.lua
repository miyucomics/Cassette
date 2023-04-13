local Colors = require("core/colors")
local Cursor = {
	width = 25,
	height = 15,
	rotation = 0,
	da = 0,
	data = nil
}

function Cursor.update (deltaTime)
	Cursor.rotation = Cursor.rotation + Cursor.da * deltaTime
end

function Cursor.draw ()
	if Cursor.data then
		for i = 0, 3, 1 do
			love.graphics.push()
			love.graphics.translate(Cursor.x, Cursor.y - i)
			love.graphics.rotate(Cursor.rotation)
			if i == 3 then
				love.graphics.setColor(Colors.Subtext0)
				love.graphics.rectangle("fill", -Cursor.width / 2, -Cursor.height / 2, Cursor.width, Cursor.height)
				love.graphics.setColor(Colors.Surface1)
				love.graphics.rectangle("fill", -Cursor.width / 2 + 2, -Cursor.height / 2 + 2, Cursor.width - 4, Cursor.height - 4)
				love.graphics.setColor(Colors.Text)
				love.graphics.print(Cursor.data, -4, -8)
			else
				love.graphics.setColor(Colors.Surface2)
				love.graphics.rectangle("fill", -Cursor.width / 2, -Cursor.height / 2, Cursor.width, Cursor.height)
			end
			love.graphics.pop()
		end
		love.graphics.setColor(Colors.Text)
		love.graphics.rectangle("line", Cursor.x, Cursor.y, 5, 5)
		love.graphics.rectangle("fill", Cursor.x + 2, Cursor.y + 2, 1, 1)
	end
end

function Cursor.mousemoved (x, y, dx, dy)
	Cursor.x = x
	Cursor.y = y
	Cursor.dx = dx
	Cursor.dy = dy
end

return Cursor
