local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function includes(list, value)
	assert(validate(list))
	
	for i = 1, #list do
		if list[i] == value then
			return true
		end
	end

	return false
end

return includes