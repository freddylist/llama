
local function some(dictionary, predicate)
	for k, v in pairs(dictionary) do
		if predicate(v, k) then
			return true
		end
	end

	return false
end

return some