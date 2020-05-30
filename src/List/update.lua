
local copy = require(script.Parent:WaitForChild("copy"))

local function update(dictionary, index, updater)
	local new = copy(dictionary)

	new[index] = updater(new[index])
end

return update