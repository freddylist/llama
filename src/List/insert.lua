local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.integer))

local function insert(list, index, ...)
	assert(validate(list, index))

	local len = #list

	if index < 1 then
		index = len + index
	end

	assert(index > 0 and index <= len + 1, string.format("index %d out of bounds of list of length %d", index, len))

	local new = {}
	local resultIndex = 1
	
	for i = 1, len do
		if i == index then
			for j = 1, select('#', ...) do
				new[resultIndex] = select(j, ...)
				resultIndex = resultIndex + 1
			end
		end
		
		new[resultIndex] = list[i]
		resultIndex = resultIndex + 1
	end

	return new
end

return insert