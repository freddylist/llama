local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function every(list, predicate)
	assert(validate(list, predicate))

	for i, v in ipairs(list) do
		if not predicate(v, i) then
			return false
		end
	end

	return true
end

return every