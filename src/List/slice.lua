
local function slice(list, from, to)
	assert(from <= to, "start index must be less than or equal to end index")

	local new = {}
	local index = 1

	for i = math.max(1, from), math.min(to, #list) do
		new[index] = list[i]
		index = index + 1
	end

	return new
end

return slice