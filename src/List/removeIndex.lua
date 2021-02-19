local List = script.Parent
local toSet = require(List.toSet)

local Llama = List.Parent
local t = require(Llama.t)

local validateList = t.table
local validateIndex = t.intersection(t.integer, t.numberMin(1))

local function removeIndex(list, ...)
	assert(validateList(list))

	for i = 1, select('#', ...) do
		assert(validateIndex(select(i, ...)))
	end
	
	local new = {}
	local removeIndices = toSet({...})
	local index = 1

	for i = 1, #list do
		if not removeIndices[i] then
			new[index] = list[i]
			index = index + 1
		end
	end

	return new
end

return removeIndex