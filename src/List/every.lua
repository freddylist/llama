
local function every(list, predicate)
	for i = 1, #list do
		if not predicate(list[i], i) then
			return false
		end
	end

	return true
end

return every