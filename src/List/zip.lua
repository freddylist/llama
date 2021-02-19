local List = script.Parent

local Llama = List.Parent
local t = require(Llama.t)

local validate = t.table

local function zip(...)
	local new = {}
	local argCount = select('#', ...)

	if argCount <= 0 then
		return new
	end

	local firstList = select(1, ...)

	assert(validate(firstList))

	local minLen = #firstList

	for i = 2, argCount do
		local list = select(i, ...)

		assert(validate(list))

		local len = #list

		if len < minLen then
			minLen = len
		end
	end

	for i = 1, minLen do
		new[i] = {}
		
		for j = 1, argCount do
			new[i][j] = select(j, ...)[i]
		end
	end

	return new
end

return zip