local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.intersection(t.integer, t.numberMin(1)))

local function removeIndex(list, indexToRemove)
	assert(validate(list, indexToRemove))
	
	local new = {}
	local index = 1

	for i = 1, #list do
		if i ~= indexToRemove then
			new[index] = list[i]
			index = index + 1
		end
	end

	return new
end

return removeIndex