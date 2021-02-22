local Dictionary = script.Parent
local copyDeep = require(Dictionary.copyDeep)

local Llama = Dictionary.Parent
local None = require(script.Parent.Parent.None)
local t = require(Llama.t)

local validate = t.table

local function mergeDeep(...)
	local new = {}

	for dictionaryIndex = 1, select('#', ...) do
		local dictionary = select(dictionaryIndex, ...)

		if dictionary ~= nil then
			assert(validate(dictionary))

			for key, value in pairs(dictionary) do
				if value == None then
					new[key] = nil
				elseif type(value) == "table" then
					if new[key] == nil or type(new[key]) ~= "table" then
						new[key] = copyDeep(value)
					else
						new[key] = mergeDeep(new[key], value)
					end
				else
					new[key] = value
				end
			end
		end
	end

	return new
end

return mergeDeep