local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function copyDeep(dictionary)
	assert(validate(dictionary))
	
	local new = {}

	for key, value in pairs(dictionary) do
		if type(value) == "table" then
			new[key] = copyDeep(value)
		else
			new[key] = value
		end
	end

	return new
end

return copyDeep