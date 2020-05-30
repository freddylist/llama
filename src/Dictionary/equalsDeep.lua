
local equalObjects = require(script.Parent.Parent.EqualObjects)

local function equalsDeep(...)
	if equalObjects(...) then
		return true
	end

	local argc = select('#', ...)

	for i = 1, argc do
		local dictionary = select(i, ...)

		for j = 1, argc do
			if j ~= i then
				local compare = select(j, ...)
				
				for k, v in pairs(dictionary) do
					if type(v) == "table" and type(compare[k]) == "table" and not equalsDeep(v, compare[k]) then
						return false
					elseif v ~= compare[k] then
						return false
					end
				end
			end
		end
	end

	return true
end

return equalsDeep