
local function reduceRight(list, reducer, initialReduction)
	local len = #list
	local reduction = initialReduction or list[len]
	local start = initialReduction == nil and len - 1 or len

	for i = start, 1, -1 do
		reduction = reducer(reduction, list[i], i)
	end

	return reduction
end

return reduceRight