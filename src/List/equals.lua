local List = script.Parent

local Llama = List.Parent
local equalObjects = require(Llama.equalObjects)

local function compare(a, b)
	if type(a) ~= "table" or type(b) ~= "table" then
		return a == b
	end

	local aLen = #a

	if aLen ~= #b then
		return false
	end

	for i = 1, #a do
		if a[i] ~= b[i] then
			return false
		end
	end

	return true
end

local function equals(...)
	if equalObjects(...) then
		return true
	end

	local argCount = select('#', ...)
	local firstObject = select(1, ...)

	for i = 2, argCount do
		local object = select(i, ...)

		if not compare(firstObject, object) then
			return false
		end
	end

	return true
end

return equals