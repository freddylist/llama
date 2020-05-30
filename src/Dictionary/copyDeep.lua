
local function copyDeep(dictionary)
	local new = {}

	for k, v in pairs(dictionary) do
		if type(v) == "table" then
			new[k] = copyDeep(v)
		else
			new[k] = v
		end
	end

	return new
end

return copyDeep