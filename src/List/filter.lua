
local function filter(list, filterer)
	local new = {}
	local index = 1

	for i = 1, #list do
		if filterer(list[i], i) then
			new[index] = list[i]
			index = index + 1
		end
	end
	
	return new
end

return filter