local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function filter(dictionary, filterer)
	assert(validate(dictionary, filterer))

	local new = {}

	for key, value in pairs(dictionary) do
		if filterer(value, key) then
			new[key] = value
		end
	end
	
	return new
end

return filter