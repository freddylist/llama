local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function reduce(list, reducer, initialReduction)
	assert(validate(list, reducer))

	local reduction = initialReduction
	local start = 1

	if reduction == nil then
		reduction = list[1]
		start = 2
	end

	for i = start, #list do
		reduction = reducer(reduction, list[i], i)
	end

	return reduction
end

return reduce