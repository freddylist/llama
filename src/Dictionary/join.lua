local Dictionary = script.Parent

local Llama = Dictionary.Parent
local None = require(Llama.None)
local t = require(Llama.t)

local validate = t.table

local function join(...)
	local new = {}

	for dictionaryIndex = 1, select('#', ...) do
		local dictionary = select(dictionaryIndex, ...)

		if dictionary ~= nil then
			assert(validate(dictionary))
			
			for k, v in pairs(dictionary) do
				if v == None then
					new[k] = nil
				else
					new[k] = v
				end
			end
		end
	end

	return new
end

return join