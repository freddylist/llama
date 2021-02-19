local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function copyDeep(list)
	assert(validate(list))
	
	local new = {}

	for i = 1, #list do
		if type(list[i]) == "table" then
			new[i] = copyDeep(list[i])
		else
			new[i] = list[i]
		end
	end
	
	return new
end

return copyDeep