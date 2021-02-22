local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function some(dictionary, predicate)
	assert(validate(dictionary, predicate))

	for key, value in pairs(dictionary) do
		if predicate(value, key) then
			return true
		end
	end

	return false
end

return some