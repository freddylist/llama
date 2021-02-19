local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function copyDeep(dictionary)
	assert(validate(dictionary))
	
	local new = {}

	for k, v in pairs(dictionary) do
		if type(v) == "table" then
			new[k] = copyDeep(v)
		else
			new[k] = v
		end
	end

	return new
end

return copyDeep