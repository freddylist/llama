local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.intersection(t.integer, t.numberMin(0))))

local function flatten(list, depth)
	assert(validate(list))
	
	local new = {}
	local index = 1

	for i = 1, #list do
		if type(list[i]) == "table" and (not depth or depth > 0) then
			local subList = flatten(list[i], depth and depth - 1)

			for j = 1, #subList do
				new[index] = subList[j]
				index = index + 1
			end
		else
			new[index] = list[i]
			index = index + 1
		end
	end

	return new
end

return flatten