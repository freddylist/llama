
local function remove(dictionary, key)
	local new = {}

	for k, v in pairs(dictionary) do
		if k ~= key then
			new[k] = v
		end
	end

	return new
end

return remove