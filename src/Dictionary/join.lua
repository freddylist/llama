
local None = require(script.Parent.Parent:WaitForChild("None"))

local function join(...)
	local new = {}

	for dictionaryIndex = 1, select("#", ...) do
		local dictionary = select(dictionaryIndex, ...)

		for k, v in pairs(dictionary) do
			if v == None then
				new[k] = nil
			else
				new[k] = v
			end
		end
	end

	return new
end

return join