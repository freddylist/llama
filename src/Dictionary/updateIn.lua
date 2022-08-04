local Dictionary = script.Parent

local Llama = Dictionary.Parent
local t = require(Llama.t)


local removeKey = require(script.Parent.removeKey)
local set = require(script.Parent.set)
local map = require(script.Parent.map)
local slice = require(script.Parent.Parent.List.slice)

local function quoteString(value)
	return string.format("%q", value)
end

local function throw(existing, keyPath, i)
	error(string.format(
		"Cannot update within non-table value in path [%s] = %s",
		table.concat(map(slice(keyPath, 1, i - 1), quoteString), ", "),
		tostring(existing)
	))
end

local function updateInDeeply(existing, keyPath, notSetValue, updater, i)
	local wasNotSet = existing == nil
	if i > #keyPath then
		local existingValue = wasNotSet and notSetValue or existing
		local newValue = updater(existingValue)
		return newValue == existingValue and existing or newValue
	end

	if not wasNotSet and type(existing) ~= "table" then
		throw(existing, keyPath, i)
	end

	local key = keyPath[i]
	local nextExisting
	if wasNotSet then
		nextExisting = notSetValue and notSetValue[key] or nil
	else
		nextExisting = existing[key]
	end

	local nextUpdated = updateInDeeply(nextExisting, keyPath, notSetValue, updater, i + 1)

	if nextUpdated == nil then
		if existing or notSetValue then
			return removeKey(existing or notSetValue, key)
		end
	else
		if existing or notSetValue then
			return set(existing or notSetValue, key, nextUpdated)
		else
			throw(existing, keyPath, i)
		end
	end

	return nil
end

local validate = t.tuple(t.table, t.array(t.string), t.optional(t.callback), t.optional(t.any))

return function(dictionary, keyPath, updater, notSetValue)
	assert(validate(dictionary, keyPath, updater, notSetValue))

	local updatedValue = updateInDeeply(
		dictionary, keyPath, notSetValue, updater, 1
	)

	return updatedValue or notSetValue
end
