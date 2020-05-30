
local function some(list, predicate)
	for i = 1, #list do
		if predicate(list[i], i) then
			return true
		end
	end

	return false
end

return some