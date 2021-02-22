local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function map(set, mapper)
	assert(validate(set, mapper))

	local new = {}

	for key, _ in pairs(set) do
		local newKey = mapper(key)

		if newKey ~= nil then
			new[newKey] = true
		end
	end

	return new
end

return map