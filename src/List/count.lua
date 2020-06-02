
local function count(list, predicate)
	local listType = type(list)
	assert(listType == "table", "expected a table for first argument, got " .. listType)
	
	local predicateType = type(predicate)
	assert(predicateType == "function", "expected a function for second argument, got " .. predicateType)
	
	local counter = 0

	for i = 1, #list do
		if predicate(list[i], i) then
			counter = counter + 1
		end
	end

	return counter
end

return count