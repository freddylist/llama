
local function slice(list, from, to)
	local new = {}

	for i = from, to do
		new[to - i] = list[i]
	end

	return new
end

return slice