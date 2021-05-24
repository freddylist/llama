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

	for _, v in ipairs(list) do
		if not valuesSet[v] then
			new[index] = v
			index += 1
		end
	end

	return new
end

return removeValue