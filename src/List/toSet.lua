
local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function toSet(list)
	assert(validate(list))

	local set = {}

	for _, v in ipairs(list) do
		set[v] = true
	end

	return set
end

return toSet