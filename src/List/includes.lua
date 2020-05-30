
local function includes(list, value)
	for i = 1, #list do
		if list[i] == value then
			return true
		end
	end

	return false
end

return includes