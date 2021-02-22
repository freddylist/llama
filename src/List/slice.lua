local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local indexType = t.optional(t.integer)
local validate = t.tuple(t.table, indexType, indexType)

local function slice(list, from, to)
	assert(validate(list, from, to))
	
	local len = #list

	from = from or 1
	to = to or len

	if from < 1 then
		from = len + from
	end

	if to < 1 then
		to = len + to
	end

	assert(from > 0 and from <= len + 1, string.format("index %d out of bounds of list of length %d", from, len))
	assert(to > 0 and to <= len + 1, string.format("index %d out of bounds of list of length %d", to, len))
	assert(from <= to, string.format("start index %d cannot be greater than end index %d", from, to))

	local new = {}
	local index = 1

	for i = from, to do
		new[index] = list[i]
		index = index + 1
	end

	return new
end

return slice