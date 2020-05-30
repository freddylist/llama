
local function every(dictionary, predicate)
	for k, v in pairs(dictionary) do
		if not predicate(v, k) then
			return false
		end
	end

	return true
end

return every