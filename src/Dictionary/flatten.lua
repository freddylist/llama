
local join = require(script.Parent:WaitForChild("join"))

local function flatten(dictionary)
	local new = {}

	for k, v in pairs(dictionary) do
		if type(v) == "table" then
			new = join(flatten(v), new)
		else
			new[k] = v
		end
	end

	return new
end

return flatten