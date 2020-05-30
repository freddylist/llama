
local function find(list, value, from)
	for i = from or #list, 1, -1 do
		if list[i] == value then
			return i
		end
	end

	return 0
end

return find