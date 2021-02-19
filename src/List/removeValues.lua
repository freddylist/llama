local List = script.Parent
local toSet = require(List.toSet)

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function removeValue(list, ...)
	assert(validate(list))
	
	local valuesSet = toSet({...})
	local new = {}
	local index = 1

	for i = 1, #list do
		if not valuesSet[list[i]] then
			new[index] = list[i]
			index = index + 1
		end
	end

	return new
end

return removeValue