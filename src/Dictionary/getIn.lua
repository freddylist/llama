return function(dictionary, keyPath, default)
	local dictionaryType = type(dictionary)
	assert(dictionaryType == "table", "expected a table for first argument, got " .. dictionaryType)
	assert(type(keyPath) == "table", string.format("Invalid keyPath: expected array: %s", tostring(keyPath)))

	local node = dictionary
	for _, path in ipairs(keyPath) do
		node = node[path]
		if not node then
			return default
		end
	end

	return node
end
