local updateIn = require(script.Parent.updateIn)

return function(dictionary, keyPath, value)
	local result = updateIn(dictionary, keyPath, function()
		return value
	end, {})

	return result
end
