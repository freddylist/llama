local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.intersection(t.integer, t.numberMin(0))))

local function pop(list, numPops)
	assert(validate(list, numPops))

	local len = #list

	numPops = numPops or 1

	assert(numPops > 0 and numPops <= len + 1, string.format("index %d out of bounds of list of length %d", numPops, len))

	local new = {}

	for i = 1, #list - numPops do
		new[i] = list[i]
	end

	return new
end

return pop