
local function shift(list)
	local new = {}

	for i = 2, #list do
		new[i - 1] = list[i]
	end
end

return shift