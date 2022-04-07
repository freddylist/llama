local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)

local validate = t.tuple(t.table, t.array(t.string), t.optional(t.any))

return function(dictionary, keyPath, default)
	assert(validate(dictionary, keyPath, default))

	local node = dictionary
	for _, path in ipairs(keyPath) do
		node = node[path]
		if not node then
			return default
		end
	end

	return node
end
