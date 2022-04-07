local updateIn = require(script.Parent.updateIn)

return function(dictionary, keyPath)
	return updateIn(dictionary, keyPath, function()
		return nil
	end, nil)
end
