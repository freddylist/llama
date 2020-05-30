
local copy = require(script.Parent.copy)

local function update(dictionary, key, updater)
	local new = copy(dictionary)

	new[key] = updater(new[key])
end

return update