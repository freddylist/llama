
local function copy(dictionary)
	local new = {}

	for k, v in pairs(dictionary) do
		new[k] = v
	end

	return new
end

return copy