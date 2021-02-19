local Dictionary = script.Parent

local Llama = Dictionary.Parent
local equalObjects = require(Llama.equalObjects)

local function compare(a, b)
	if type(a) ~= "table" or type(b) ~= "table" then
		return a == b
	end

	for k, v in pairs(a) do
		if b[k] ~= v then
			return false
		end
	end

	for k, v in pairs(b) do
		if a[k] ~= v then
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