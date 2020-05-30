
local copy = require(script.Parent:WaitForChild("copy"))

local function set(dictionary, key, value)
	local new = copy(dictionary)

	new[key] = value
end

return set