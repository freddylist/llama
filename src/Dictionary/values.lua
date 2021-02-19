local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function values(dictionary)
	assert(validate(dictionary))
	
	local valuesList = {}

	local index = 1

	for _, v in pairs(dictionary) do
		valuesList[index] = v
		index = index + 1
	end

	return valuesList
end

return values