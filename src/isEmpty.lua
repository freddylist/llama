local Llama = script.Parent
local t = require(Llama.t)

local validate = t.table

local function isEmpty(object)
	assert(validate(object))

	return next(object) == nil
end

return isEmpty