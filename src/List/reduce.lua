
local function reduce(list, reducer, initialReduction)
	local reduction = initialReduction or list[1]
	local start = initialReduction == nil and 2 or 1

	for i = start, #list do
		reduction = reducer(reduction, list[i], i)
	end

	return reduction
end

return reduce