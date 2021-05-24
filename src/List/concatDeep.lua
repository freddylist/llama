local List = script.Parent
local copyDeep = require(List.copyDeep)

local Llama = List.Parent
local None = require(Llama.None)
local t = require(Llama.t)

local validate = t.table

local function concatDeep(...)
	local new = {}
	local index = 1

	for listIndex = 1, select('#', ...) do
		local list = select(listIndex, ...)

		if list ~= nil then
			assert(validate(list))

			for _, v in ipairs(list) do
				if v ~= None then
					if type(v) == "table" then
						new[index] = copyDeep(v)
					else
						new[index] = v
					end

					index += 1
				end
			end
		end
	end

	return new
end

return concatDeep