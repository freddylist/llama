local Dictionary = script.Parent
local join = require(Dictionary.join)

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function flatMap(dictionary, mapper)
	assert(validate(dictionary, mapper))

	local new = {}

	for k, v in pairs(dictionary) do
		if type(v) == "table" then
			new = join(flatMap(v, mapper), new)
		else
			local value, key = mapper(v, k)

			new[key or k] = value
		end
	end
	
	return new
end

return flatMap