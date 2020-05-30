
local function copyDeep(list)
	local new = {}

	for i = 1, #list do
		if type(list[i]) == "table" then
			new[i] = copyDeep(list[i])
		else
			new[i] = list[i]
		end
	end
	
	return new
end