
local function includes(dictionary, value)
	for _, v in pairs(dictionary) do
		if v == value then
			return true
		end
	end

	return false
end

return includes