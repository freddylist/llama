local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.any), t.optional(t.integer))

local function find(list, value, from)
	assert(validate(list, value, from))

	local len = #list

	from = from or 1

	if from < 1 then
		from = len + from
	end

	assert(from > 0 and from <= len + 1, string.format("index %d out of bounds of list of length %d", from, len))
	
	for i = from, len do
		if list[i] == value then
			return i
		end
	end

	return nil
end

return find