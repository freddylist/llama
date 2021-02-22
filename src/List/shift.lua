local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.intersection(t.integer, t.numberMin(0))))

local function shift(list, numPlaces)
	assert(validate(list, numPlaces))

	local len = #list
	
	numPlaces = numPlaces or 1

	assert(numPlaces > 0 and numPlaces <= len + 1, string.format("index %d out of bounds of list of length %d", numPlaces, len))
	
	local new = {}

	for i = 1 + numPlaces, len do
		new[i - numPlaces] = list[i]
	end

	return new
end

return shift