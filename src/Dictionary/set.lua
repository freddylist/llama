local Dictionary = script.Parent
local copy = require(Dictionary.copy)

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.any)

local function set(dictionary, key, value)
	assert(validate(dictionary, key))

	local new = copy(dictionary)

	new[key] = value

	return new
end

return set