
local function unshift(list, value)
	local new = { value }

	for i = 1, #list do
		new[i + 1] = list[i]
	end
end

return unshift