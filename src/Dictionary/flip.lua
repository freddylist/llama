local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function flip(dictionary)
	assert(validate(dictionary))
	
	local new = {}

	for key, value in pairs(dictionary) do
		new[value] = key
	end

	return new
end

return flip