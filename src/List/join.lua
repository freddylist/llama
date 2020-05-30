
local None = require(script.Parent.Parent.None)

local function join(...)
	local new = {}

	for listIndex = 1, select("#", ...) do
		local list = select(listIndex, ...)

		for i = 1, #list do
			if list[i] == None then
				new[i] = nil
			else
				new[i] = list[i]
			end
		end
	end

	return new
end

return join