
local copy = require(script.Parent.copy)

local function delete(list, ...)
	local new = copy(list)

	for i = 1, select('#', ...) do
		new[select(i, ...)] = nil
	end

	return new
end

return delete