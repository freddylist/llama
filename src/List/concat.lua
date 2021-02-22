local List = script.Parent

local Llama = List.Parent
local None = require(Llama.None)
local t = require(Llama.t)

local validate = t.table

local function concat(...)
	local new = {}
	local index = 1

	for listIndex = 1, select('#', ...) do
		local list = select(listIndex, ...)

		if list ~= nil then
			assert(validate(list))

			for i = 1, #list do
				if list[i] ~= None then
					new[index] = list[i]
					index = index + 1
				end
			end
		end
	end

	return new
end

return concat