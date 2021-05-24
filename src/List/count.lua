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

	for i, v in ipairs(list) do
		if predicate(v, i) then
			counter += 1
		end
	end

	return counter
end

return count