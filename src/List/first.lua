local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function first(list)
	assert(validate(list))

	return list[1]
end

return first