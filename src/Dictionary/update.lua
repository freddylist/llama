local Dictionary = script.Parent
local copy = require(Dictionary.copy)

local Llama = Dictionary.Parent
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
local validate = t.tuple(t.table, t.any, optionalCallbackType, optionalCallbackType)

local function update(dictionary, key, updater, callback)
	assert(validate(dictionary, key, updater, callback))

	updater = updater or noUpdate

	local new = copy(dictionary)

	if new[key] ~= nil then
		new[key] = updater(new[key], key)
	else
		new[key] = call(callback, key)
	end

	return new
end

return update