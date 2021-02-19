local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local indexType = t.optional(t.intersection(t.integer, t.numberMin(1)))
local validate = t.tuple(t.table, indexType, indexType)

local function slice(list, from, to)
	assert(validate(list, from, to))
	
	local len = #list

	from = from or 1
	to = to or len

	assert(to <= len, "index out of bounds")
	assert(from <= to, "start index cannot be greater than end index")

	local new = {}
	local index = 1

	for i = from, to do
		new[index] = list[i]
		index = index + 1
	end

	return new
end

return slice