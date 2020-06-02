
local function pop(list)
	local listType = type(list)
	assert(listType == "table", "expected a table for first argument, got " .. listType)

	local new = {}

	for i = 1, #list - 1 do
		new[i] = list[i]
	end

	return new
end

return pop