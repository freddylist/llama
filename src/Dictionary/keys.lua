local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function keys(dictionary)
	assert(validate(dictionary))
	
	local keysList = {}

	local index = 1

	for key, _ in pairs(dictionary) do
		keysList[index] = key
		index = index + 1
	end

	return keysList
end

return keys