local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.integer)

local function set(list, index, value)
	assert(validate(list, index))
	
	local len = #list

	if index < 0 then
		index = len + index
	end

	assert(index > 0 and index <= len + 1, string.format("index %d out of bounds of list of length %d", index, len))

	local new = {}
	local indexNew = 1

	for i = 1, len do
		if i == index then
			new[indexNew] = value
		else
			new[indexNew] = list[i]
		end

		indexNew += 1
	end

	return new
end

return set