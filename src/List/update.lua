local List = script.Parent
local copy = require(List.copy)

local Llama = List.Parent
local t = require(Llama.t)

local function noUpdate(value)
	return value
end

local function call(callback, ...)
	if type(callback) == "function" then
		return callback(...)
	end
end

local optionalCallbackType = t.optional(t.callback)
local validate = t.tuple(t.table, t.intersection(t.integer, t.numberMin(1)), optionalCallbackType, optionalCallbackType)

local function update(list, index, updater, callback)
	assert(validate(list, index, updater, callback))
	assert(index <= #list + 1, "index out of bounds")

	updater = updater or noUpdate

	local new = copy(list)

	if new[index] ~= nil then
		new[index] = updater(new[index], index)
	else
		new[index] = call(callback, index)
	end

	return new
end

return update