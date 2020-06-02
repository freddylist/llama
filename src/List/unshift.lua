
local function unshift(list, value)
	local listType = type(list)
	assert(listType == "table", "expected a table for first argument, got " .. listType)

	assert(value ~= nil, "expected anything but nil for second argument")

	local new = { value }

	for i = 1, #list do
		new[i + 1] = list[i]
	end
end

return unshift