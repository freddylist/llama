local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function map(dictionary, mapper)
	assert(validate(dictionary, mapper))

	local new = {}

	for key, value in pairs(dictionary) do
		local newValue, newKey = mapper(value, key)
		new[newKey or key] = newValue
	end

	return new
end

return map