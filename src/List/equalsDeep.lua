
local equalObjects = require(script.Parent.Parent.equalObjects)

local function equalsDeep(...)
	if equalObjects(...) then
		return true
	end

	local argc = select('#', ...)

	for i = 1, argc do
		local list = select(i, ...)

		for j = 1, argc do
			if j ~= i then
				local compare = select(j, ...)
				
				for k = 1, #list do
					if (type(list[k]) == "table" 
						and type(compare[k]) == "table" 
						and not equalsDeep(list[k], compare[k])
					) or list[k] ~= compare[k]
					then
						return false
					end
				end
			end
		end
	end

	return true
end

return equalsDeep