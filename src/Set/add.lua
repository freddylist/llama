local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.table

local function add(set, ...)
	assert(validate(set))

	local new = {}

	for k, _ in pairs(set) do
		new[k] = true
	end

	for i = 1, select('#', ...) do
		new[select(i, ...)] = true
	end

	return new
end

return add