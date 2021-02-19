local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function map(dictionary, mapper)
	assert(validate(dictionary, mapper))

	local mapped = {}

	for k, v in pairs(dictionary) do
		local value, key = mapper(v, k)
		mapped[key or k] = value
	end

	return mapped
end

return map