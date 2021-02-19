local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local indexType = t.optional(t.intersection(t.integer, t.numberMin(1)))
local validate = t.tuple(t.table, indexType, indexType)

local function splice(list, from, to, ...)
	assert(validate(list, from, to))

	local len = #list

	from = from or 1
	to = to or len + 1

	assert(to <= len + 1, "index out of bounds")
	assert(from <= to, "start index cannot be greater than end index")

	local new = {}
	local index = 1

	for i = 1, from - 1 do
		new[index] = list[i]
		index = index + 1
	end

	for i = 1, select('#', ...) do
		new[index] = select(i, ...)
		index = index + 1
	end

	for i = to + 1, len do
		new[index] = list[i]
		index = index + 1
	end

	return new
end

return splice