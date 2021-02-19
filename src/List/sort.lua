local List = script.Parent
local copy = require(List.copy)

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.callback))

local function sort(list, comparator)
	assert(validate(list, comparator))
	
	local new = copy(list)

	table.sort(new, comparator)

	return new
end

return sort