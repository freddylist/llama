local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.intersection(t.integer, t.numberPositive)))

local function pop(list, pops)
	assert(validate(list, pops))

	local len = #list

	pops = pops or 1

	assert(pops <= len, "index out of bounds")

	local new = {}

	for i = 1, #list - pops do
		new[i] = list[i]
	end

	return new
end

return pop