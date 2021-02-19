
local Set = script.Parent
local isSubset = require(Set.isSubset)

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.table)

local function isSuperset(superset, subset)
	assert(validate(superset, subset))
	
	return isSubset(subset, superset)
end

return isSuperset