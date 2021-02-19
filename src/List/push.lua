local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function push(list, ...)
	assert(validate(list))
	
	local new = {}
	local len = #list

	for i = 1, len do
		new[i] = list[i]
	end

	for i = 1, select('#', ...) do
		new[len + i] = select(i, ...)
	end

	return new
end

return push