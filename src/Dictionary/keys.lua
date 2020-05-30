
local function keys(dictionary)
	local keysList = {}

	local index = 1

	for key, _ in pairs(dictionary) do
		keysList[index] = key
		index = index + 1
	end

	return keysList
end

return keys