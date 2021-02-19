local Dictionary = script.Parent
local copy = require(Dictionary.copy)

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function removeKeys(dictionary, ...)
	assert(validate(dictionary))
	
	local new = copy(dictionary)

	for i = 1, select('#', ...) do
		new[select(i, ...)] = nil
	end

	return new
end

return removeKeys