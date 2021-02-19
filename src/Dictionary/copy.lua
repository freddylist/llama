local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function copy(dictionary)
	assert(validate(dictionary))
	
	local new = {}

	for k, v in pairs(dictionary) do
		new[k] = v
	end

	return new
end

return copy