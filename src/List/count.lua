
local function count(list, predicate)
	local counter = 0

	for i = 1, #list do
		if predicate(list[i], i) then
			counter = counter + 1
		end
	end

	return counter
end

return count