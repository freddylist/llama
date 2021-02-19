local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.intersection(t.integer, t.numberMin(1))))

local function insert(list, index, ...)
	assert(validate(list, index))

	local len = #list

	assert(index <= len + 1, "index out of bounds")

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