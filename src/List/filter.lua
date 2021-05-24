local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function filter(list, filterer)
	assert(validate(list, filterer))

	local new = {}
	local index = 1

	for i, v in ipairs(list) do
		if filterer(v, i) then
			new[index] = v
			index += 1
		end
	end

	return new
end

return filter