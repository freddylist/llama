local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function map(list, mapper)
	assert(validate(list, mapper))
	
	local new = {}
	local index = 1

	for i = 1, #list do
		local value = mapper(list[i], i)

		if value ~= nil then
			new[index] = value
			index = index + 1
		end
	end
	
	return new
end

return map