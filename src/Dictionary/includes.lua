local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function includes(dictionary, value)
	assert(validate(dictionary))
	
	for _, v in pairs(dictionary) do
		if v == value then
			return true
		end
	end

	return false
end

return includes