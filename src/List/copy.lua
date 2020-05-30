
local function copy(list)
	local new = {}

	for i = 1, #list do
		new[i] = list[i]
	end
	
	return new
end

return copy