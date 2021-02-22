local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.optional(t.intersection(t.integer, t.numberMin(0))))

local function flatten(dictionary, depth)
	assert(validate(dictionary, depth))
	
	local new = {}

	for key, value in pairs(dictionary) do
		if type(value) == "table" and (not depth or depth > 0) then
			local subDictionary = flatten(value, depth and depth - 1)

			for newKey, newValue in pairs(new) do
				subDictionary[newKey] = newValue
			end

			new = subDictionary
		else
			new[key] = value
		end
	end

	return new
end

return flatten