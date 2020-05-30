
local function map(list, mapper)
	local new = {}
	local index = 1

	for i = 1, #list do
		local value = mapper(list[i], i)

		if value ~= nil then
			new[index] = value
			index = index + 1
		end
	end
	
	return new
end

return map