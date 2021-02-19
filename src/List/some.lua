local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function some(list, predicate)
	assert(validate(list, predicate))
	
	for i = 1, #list do
		if predicate(list[i], i) then
			return true
		end
	end

	return false
end

return some