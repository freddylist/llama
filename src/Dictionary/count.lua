local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local function alwaysTrue()
	return true
end

local validate = t.tuple(t.table, t.optional(t.callback))

local function count(dictionary, predicate)
	assert(validate(dictionary, predicate))

	predicate = predicate or alwaysTrue
	
	local counter = 0

	for key, value in pairs(dictionary) do
		if predicate(value, key) then
			counter = counter + 1
		end
	end

	return counter
end

return count