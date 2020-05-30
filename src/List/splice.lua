
local function splice(list, start, finish, ...)
	local new = {}
	local index = 1

	for i = 1, #new do
		if i == start then
			for j = 1, select('#', ...) do
				new[index] = select(j, ...)
				index = index + 1
			end

			i = finish
		else
			new[index] = list[i]
			index = index + 1
		end
	end
end

return splice