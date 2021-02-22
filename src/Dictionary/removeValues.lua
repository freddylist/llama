local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local List = Llama.List
local toSet = require(List.toSet)

local validate = t.table

local function removeValues(dictionary, ...)
	assert(validate(dictionary))
	
	local valuesSet = toSet({...})

	local new = {}

	for key, value in pairs(dictionary) do
		if not valuesSet[value] then
			new[key] = value
		end
	end

	return new
end

return removeValues