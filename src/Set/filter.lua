local Set = script.Parent

local Llama = Set.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.callback)

local function filter(set, filterer)
	assert(validate(set, filterer))

	local new = {}

	for key, _ in pairs(set) do
		if filterer(key) then
			new[key] = true
		end
	end
	
	return new
end

return filter