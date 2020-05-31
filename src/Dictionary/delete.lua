
local copy = require(script.Parent.copy)

local function delete(dictionary, ...)
	local new = copy(dictionary)

	for i = 1, select('#', ...) do
		new[select(i, ...)] = nil
	end

	return new
end

return delete