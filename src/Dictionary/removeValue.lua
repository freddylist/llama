local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function removeValue(dictionary, valueToRemove)
	assert(validate(dictionary))

	local new = {}

	for key, value in pairs(dictionary) do
		if value ~= valueToRemove then
			new[key] = value
		end
	end

	return new
end

return removeValue