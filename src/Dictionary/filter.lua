local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function filter(dictionary, filterer)
	assert(validate(dictionary, filterer))

	local new = {}

	for k, v in pairs(dictionary) do
		if filterer(v, k) then
			new[k] = v
		end
	end
	
	return new
end

return filter