
local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.table)

local function isSubset(subset, superset)
	assert(validate(subset, superset))
	
	for key, value in pairs(subset) do
		if superset[key] ~= value then
			return false
		end
	end

	return true
end

return isSubset