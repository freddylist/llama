
local function set(list, index, value)
	local new = {}
	local resultIndex = 1

	for i = 1, #list do
		if i == index then
			new[resultIndex] = value
		else
			new[resultIndex] = list[i]
		end

		resultIndex = resultIndex + 1
	end
end

return set