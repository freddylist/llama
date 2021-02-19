local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback, t.optional(t.intersection(t.integer, t.numberMin(1))))

local function findWhere(list, predicate, from)
	assert(validate(list, predicate, from))

	local len = #list

	from = from or 1

	assert(len == 0 or from <= len, "index out of bounds")

	for i = from, len do
		if predicate(list[i], i) then
			return i
		end
	end

	return nil
end

return findWhere