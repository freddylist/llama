local List = script.Parent

local Llama = List.Parent
local None = require(Llama.None)
local t = require(Llama.t)

local validate = t.table

local function zipAll(...)
	local new = {}
	local argCount = select('#', ...)
	local maxLen = 0

	for i = 1, argCount do
		local list = select(i, ...)

		assert(validate(list))

		local len = #list

		if len > maxLen then
			maxLen = len
		end
	end

	for i = 1, maxLen do
		new[i] = {}
		
		for j = 1, argCount do
			local value = select(j, ...)[i]

			if value == nil then
				new[i][j] = None
			else
				new[i][j] = select(j, ...)[i]
			end
		end
	end

	return new
end

return zipAll