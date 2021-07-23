local Dictionary = script.Parent
local copy = require(Dictionary.copy)

local Llama = Dictionary.Parent
local t = require(Llama.Parent.t)

local validate = t.table

local function removeKey(dictionary, key)
	assert(validate(dictionary))

	local new = copy(dictionary)

	new[key] = nil

	return new
end

return removeKey
