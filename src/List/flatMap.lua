local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function flatMap(list, mapper)
	assert(validate(list, mapper))

	local new = {}
	local index = 1

	for i = 1, #list do
		if type(list[i]) == "table" then
			local layer = flatMap(list[i], mapper)

			for j = 1, #layer do
				new[index] = layer[j]
				index = index + 1
			end
		else
			local value = mapper(list[i], i)

			if value ~= nil then
				new[index] = value
				index = index + 1
			end
		end
	end
	
	return new
end

return flatMap