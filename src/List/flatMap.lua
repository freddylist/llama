
local join = require(script.Parent:WaitForChild("join"))

local function flatMap(list, mapper)
	local flatMapped = {}
	local index = 1

	for i = 1, #list do
		if type(list[i]) == "table" then
			local layer = flatMap(list[i], mapper)

			flatMapped = join(layer, flatMapped)
			index = index + #layer + 1
		else
			local value = mapper(list[i], i)

			if value ~= nil then
				flatMapped[index] = value
				index = index + 1
			end
		end
	end
	
	return flatMapped
end

return flatMap