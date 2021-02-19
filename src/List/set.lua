local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.intersection(t.integer, t.numberMin(1)))

local function set(list, index, value)
	assert(validate(list, index))
	
	local len = #list

	assert(index <= len + 1, "index out of bounds")

	local new = {}
	local indexNew = 1

	for i = 1, len do
		if i == index then
			new[indexNew] = value
		else
			new[indexNew] = list[i]
		end

		indexNew = indexNew + 1
	end

	return new
end

return set