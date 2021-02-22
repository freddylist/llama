local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.table

local function toList(set)
	assert(validate(set))

	local new = {}
	local index = 1

	for key, _ in pairs(set) do
		new[index] = key
		index = index + 1
	end

	return new
end

return toList