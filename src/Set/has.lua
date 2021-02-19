local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.any)

local function has(set, key)
	assert(validate(set, key))
	
	return set[key] == true
end

return has