
local join = require(script.Parent.join)

local function flatten(list)
	local listType = type(list)
	assert(listType == "table", "expected a table for first argument, got " .. listType)
	
	local new = {}

	for i = 1, #list do
		if type(list[i]) == "table" then
			new = join(flatten(list[i]), new)
		else
			new[i] = list[i]
		end
	end

	return new
end

return flatten