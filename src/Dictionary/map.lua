
local function map(dictionary, mapper)
	local mapped = {}

	for k, v in pairs(dictionary) do
		local value, key = mapper(v, k)
		mapped[key or k] = value
	end

	return mapped
end

return map