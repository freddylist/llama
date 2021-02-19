local Dictionary = script.Parent
local join = require(Dictionary.join)

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.table

local function flatten(dictionary)
	assert(validate(dictionary))
	
	local new = {}

	for k, v in pairs(dictionary) do
		if type(v) == "table" then
			new = join(flatten(v), new)
		else
			new[k] = v
		end
	end

	return new
end

return flatten