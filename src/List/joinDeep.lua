
local None = require(script.Parent.Parent.None)
local copyDeep = require(script.Parent.copyDeep)

local function joinDeep(...)
	local new = {}

	for listIndex = 1, select("#", ...) do
		local list = select(listIndex, ...)

		for i = 1, #list do
			if list[i] == None then
				new[i] = nil
			elseif type(list[i]) == "table" then
				if new[i] == nil or type(new[i] ~= "table") then
					new[i] = copyDeep(list[i])
				else
					new[i] = joinDeep(new[i], list[i])
				end
			else
				new[i] = list[i]
			end
		end
	end

	return new
end

return joinDeep