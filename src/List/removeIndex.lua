local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.integer)

local function removeIndex(list, indexToRemove)
	assert(validate(list, indexToRemove))

	local len = #list

	if indexToRemove < 1 then
		indexToRemove += len
	end

	assert(indexToRemove > 0 and indexToRemove <= len, string.format("index %d out of bounds of list of length %d", indexToRemove, len))

	local new = {}
	local index = 1

	for i, v in ipairs(list) do
		if i ~= indexToRemove then
			new[index] = v
			index += 1
		end
	end

	return new
end

return removeIndex