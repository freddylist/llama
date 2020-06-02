
local function toList(set)
	local new = {}
	local index = 1

	for k, _ in pairs(set) do
		new[index] = k
	end

	return new
end

return toList