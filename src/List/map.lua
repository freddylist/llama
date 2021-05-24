local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function map(list, mapper)
	assert(validate(list, mapper))

	local new = {}
	local index = 1

	for i, v in ipairs(list) do
		local value = mapper(v, i)

		if value ~= nil then
			new[index] = value
			index += 1
		end
	end

	return new
end

return map