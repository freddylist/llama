local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validateList = t.table
local validateIndex = t.integer

local function removeIndices(list, ...)
	assert(validateList(list))

	local len = #list
	local indicesToRemove = {}

	for i = 1, select('#', ...) do
		local index = select(i, ...)
		
		assert(validateIndex(index))

		if index < 1 then
			index = len + index
		end

		assert(index > 0 and index <= len, string.format("index %d out of bounds of list of length %d", index, len))

		indicesToRemove[index] = true
	end
	
	local new = {}
	local index = 1

	for i = 1, len do
		if not indicesToRemove[i] then
			new[index] = list[i]
			index = index + 1
		end
	end

	return new
end

return removeIndices