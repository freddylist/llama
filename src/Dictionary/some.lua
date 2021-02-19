local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function some(dictionary, predicate)
	assert(validate(dictionary, predicate))

	for k, v in pairs(dictionary) do
		if predicate(v, k) then
			return true
		end
	end

	return false
end

return some