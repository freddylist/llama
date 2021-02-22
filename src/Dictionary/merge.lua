local Dictionary = script.Parent

local Llama = Dictionary.Parent
local None = require(Llama.None)
local t = require(Llama.t)

local validate = t.table

local function merge(...)
	local new = {}

	for dictionaryIndex = 1, select('#', ...) do
		local dictionary = select(dictionaryIndex, ...)

		if dictionary ~= nil then
			assert(validate(dictionary))
			
			for key, value in pairs(dictionary) do
				if value == None then
					new[key] = nil
				else
					new[key] = value
				end
			end
		end
	end

	return new
end

return merge