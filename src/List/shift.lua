local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.intersection(t.integer, t.numberPositive)))

local function shift(list, shifts)
	assert(validate(list, shifts))

	local len = #list
	
	shifts = shifts or 1

	assert(shifts <= len, "index out of bounds")
	
	local new = {}

	for i = 1 + shifts, len do
		new[i - shifts] = list[i]
	end

	return new
end

return shift