local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function copy(dictionary)
	assert(validate(dictionary))
	
	local new = {}

	for key, value in pairs(dictionary) do
		new[key] = value
	end

	return new
end

return copy