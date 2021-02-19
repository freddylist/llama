local List = script.Parent
local copyDeep = require(List.copyDeep)

local Llama = List.Parent
local None = require(Llama.None)
local t = require(Llama.t)

local validate = t.table

local function joinDeep(...)
	local new = {}

	local index = 1

	for listIndex = 1, select('#', ...) do
		local list = select(listIndex, ...)

		if list ~= nil then
			assert(validate(list))
			
			for i = 1, #list do
				if list[i] ~= None then
					if type(list[i]) == "table" then
						new[index] = copyDeep(list[i])
					else
						new[index] = list[i]
					end

					index = index + 1
				end
			end
		end
	end

	return new
end

return joinDeep