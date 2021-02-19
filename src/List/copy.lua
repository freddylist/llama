local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function copy(list)
	assert(validate(list))

	local new = {}

	for i = 1, #list do
		new[i] = list[i]
	end
	
	return new
end

return copy