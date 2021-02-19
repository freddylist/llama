local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function reduceRight(list, reducer, initialReduction)
	assert(validate(list, reducer))

	local len = #list
	local reduction = initialReduction
	local start = len

	if reduction == nil then
		reduction = list[len]
		start = len - 1
	end

	for i = start, 1, -1 do
		reduction = reducer(reduction, list[i], i)
	end

	return reduction
end

return reduceRight