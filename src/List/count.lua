local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local function alwaysTrue()
	return true
end

local validate = t.tuple(t.table, t.optional(t.callback))

local function count(list, predicate)
	assert(validate(list, predicate))
	
	predicate = predicate or alwaysTrue
	
	local counter = 0

	for i = 1, #list do
		if predicate(list[i], i) then
			counter = counter + 1
		end
	end

	return counter
end

return count