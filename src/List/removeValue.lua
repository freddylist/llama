local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function removeValue(list, value)
	assert(validate(list))

	local new = {}
	local index = 1

	for _, v in ipairs(list) do
		if v ~= value then
			new[index] = v
			index += 1
		end
	end

	return new
end

return removeValue