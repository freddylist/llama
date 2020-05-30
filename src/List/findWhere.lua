
local function find(list, predicate, from)
	for i = from or 1, #list do
		if predicate(list[i], i) then
			return i
		end
	end

	return nil
end

return find