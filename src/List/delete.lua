
local toSet = require(script.Parent.toSet)

local function delete(list, ...)
	local new = {}
	local removeIndices = toSet({...})
	local index = 1

	for i = 1, #list do
		if not removeIndices[i] then
			new[index] = list[i]
			index = index + 1
		end
	end

	return new
end

return delete