local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function unshift(list, ...)
	assert(validate(list))

	local argCount = select('#', ...)

	local new = {}

	for i = 1, argCount do
		new[i] = select(i, ...)
	end

	for i, v in ipairs(list) do
		new[argCount + i] = v
	end

	return new
end

return unshift