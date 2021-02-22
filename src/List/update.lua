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
local validate = t.tuple(t.table, t.integer, optionalCallbackType, optionalCallbackType)

local function update(list, index, updater, callback)
	assert(validate(list, index, updater, callback))

	local len = #list

	if index < 0 then
		index = len + index
	end

	assert(index > 0 and index <= len + 1, string.format("index %d out of bounds of list of length %d", index, len))

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