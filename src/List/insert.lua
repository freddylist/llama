
local function insert(list, index, ...)
	local listType = type(list)
	assert(listType == "table", "expected a table for first argument, got " .. listType)

	local new = {}
	local resultIndex = 1
	
	for i = 1, #list do
		if i == index then
			for j = 1, select('#', ...) do
				new[resultIndex] = select(j, ...)
				resultIndex = resultIndex + 1
			end
		end
		
		new[resultIndex] = list[i]
		resultIndex = resultIndex + 1
	end

	return new
end

return insert