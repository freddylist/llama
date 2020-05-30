
local function pop(list)
	local new = {}

	for i = 1, #list - 1 do
		new[i] = list[i]
	end

	return new
end

return pop