local Manager = {
	classes = {}
}

function Manager:register (class)
	table.insert(self.classes, class)
end

function Manager:emit (name, ...)
	for _, class in pairs(self.classes) do
		if class[name] then
			class[name](...)
		end
	end
end

return Manager
