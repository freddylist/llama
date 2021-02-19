local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function last(list)
	assert(validate(list))

	return list[#list]
end

return last