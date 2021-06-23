local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local function alwaysTrue()
	return true
end

local validate = t.table

local function findKey(dictionary, value, predicate)
	assert(validate(dictionary))

	predicate = predicate or alwaysTrue
	
	for k, v in pairs(dictionary) do
		if v == value and predicate(k) then
			return k
		end
	end

	return nil
end

return findKey