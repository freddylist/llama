
local function remove(list, index)
	local new = {}

	local resultIndex = 1

	for i = 1, #list do
		if i ~= index then
			new[resultIndex] = list[i]
			resultIndex = resultIndex + 1
		end
	end

	return new
end

return remove