local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.table

local function intersect(...)
	local new = {}
	local argCount = select('#', ...)
	local firstSet = select(1, ...)

	assert(validate(firstSet))

	for k, _ in pairs(firstSet) do
		local intersects = true

		for i = 2, argCount do
			local set = select(i, ...)

			assert(validate(set))

			if set[k] == nil then
				intersects = false
				break
			end
		end

		if intersects then
			new[k] = true
		end
	end

	return new
end

return intersect