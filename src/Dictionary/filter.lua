
local function filter(dictionary, filterer)
	local new = {}

	for k, v in pairs(dictionary) do
		if filterer(v, k) then
			new[k] = v
		end
	end
	
	return new
end

return filter