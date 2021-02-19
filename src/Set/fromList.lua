local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.table

local function fromList(list)
	assert(validate(list))
	
	local set = {}

	for i = 1, #list do
		set[list[i]] = true
	end

	return set
end

return fromList