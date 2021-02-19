local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.table

local function toList(set)
	assert(validate(set))

	local new = {}
	local index = 1

	for k, _ in pairs(set) do
		new[index] = k
		index = index + 1
	end

	return new
end

return toList