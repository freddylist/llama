local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.any), t.optional(t.intersection(t.integer, t.numberMin(1))))

local function find(list, value, from)
	assert(validate(list, value, from))

	local len = #list

	from = from or 1

	assert(len == 0 or from <= len, "index out of bounds")
	
	for i = from, len do
		if list[i] == value then
			return i
		end
	end

	return nil
end

return find