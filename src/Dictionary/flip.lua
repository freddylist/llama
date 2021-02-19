local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function flip(dictionary)
	assert(validate(dictionary))
	
	local new = {}

	for k, v in pairs(dictionary) do
		new[v] = k
	end

	return new
end

return flip