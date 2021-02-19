local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function every(list, predicate)
	assert(validate(list, predicate))
	
	for i = 1, #list do
		if not predicate(list[i], i) then
			return false
		end
	end

	return true
end

return every