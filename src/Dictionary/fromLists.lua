
local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.table)

local function fromLists(keys, values)
	assert(validate(keys, values))

	local keysLen = #keys

	assert(keysLen == #values, "lists must be same size")

	local new = {}

	for i = 1, keysLen do
		new[keys[i]] = values[i]
	end

	return new
end

return fromLists