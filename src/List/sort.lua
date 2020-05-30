
local copy = require(script.Parent:WaitForChild("copy"))

local function sort(list, comparator)
	local new = copy(list)

	table.sort(new, comparator)

	return new
end

return sort