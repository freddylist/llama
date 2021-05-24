local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function copyDeep(list)
	assert(validate(list))

	local new = {}

	for i, v in ipairs(list) do
		if type(v) == "table" then
			new[i] = copyDeep(v)
		else
			new[i] = v
		end
	end

	return new
end

return copyDeep