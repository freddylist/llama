
local function flip(dictionary)
	local new = {}

	for k, v in pairs(dictionary) do
		new[v] = k
	end

	return new
end

return flip