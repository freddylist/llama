
local function shift(list)
	local listType = type(list)
	assert(listType == "table", "expected a table for first argument, got " .. listType)
	
	local new = {}

	for i = 2, #list do
		new[i - 1] = list[i]
	end
end

return shift