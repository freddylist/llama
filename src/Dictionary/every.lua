local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function every(dictionary, predicate)
	assert(validate(dictionary, predicate))
	
	for k, v in pairs(dictionary) do
		if not predicate(v, k) then
			return false
		end
	end

	return true
end

return every