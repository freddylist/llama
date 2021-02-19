local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local List = Llama.List
local toSet = require(List.toSet)

local validate = t.table

local function removeValue(dictionary, ...)
	assert(validate(dictionary))
	
	local valuesSet = toSet({...})

	local new = {}

	for k, v in pairs(dictionary) do
		if not valuesSet[v] then
			new[k] = v
		end
	end

	return new
end

return removeValue