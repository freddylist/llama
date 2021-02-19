local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function flatten(list)
	assert(validate(list))
	
	local new = {}
	local index = 1

	for i = 1, #list do
		if type(list[i]) == "table" then
			local layer = flatten(list[i])

			for j = 1, #layer do
				new[index] = layer[j]
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