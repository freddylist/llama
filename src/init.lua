
local llama = {}

local None = newproxy(true)
getmetatable(None).__tostring = function() 
	return "Llama.None" 
end

function llama.isEmpty(chair)
	return next(chair) == nil
end

local Dictionary = {}

function Dictionary.join(...)
	local joined = {}

	for dictionaryIndex = 1, select("#", ...) do
		for key, value in pairs(select(dictionaryIndex, ...)) do
			if value == None then
				joined[key] = nil
			else
				joined[key] = value
			end
		end
	end

	return joined
end

function Dictionary.keys(dictionary)
	local keys = {}

	local index = 1

	for key, _ in pairs(dictionary) do
		keys[index] = key
		index = index + 1
	end

	return keys
end

function Dictionary.values(dictionary)
	local values = {}

	local index = 1

	for _, value in pairs(dictionary) do
		values[index] = value
		index = index + 1
	end

	return values
end

function Dictionary.shallowCopy(dictionary)
	local copy = {}

	for key, value in pairs(dictionary) do
		copy[key] = value
	end

	return copy
end

function Dictionary.deepCopy(dictionary)
	local copy = {}

	for key, value in pairs(dictionary) do
		if type(value) == "table" then
			copy[key] = Dictionary.deepCopy(value)
		else
			copy[key] = value
		end
	end

	return copy
end

local List = {}

function List.join(...)
	local joined = {}

	local index = 1

	for listIndex = 1, select("#", ...) do
		local list = select(listIndex, ...)

		for i = 1, #list do
			if list[i] == None then
				index = index - 1
			else
				joined[index] = list[i]
				index = index + 1
			end
		end
	end

	return joined
end

function List.shallowCopy(list)
	local copy = {}

	for i = 1, #list do
		copy[i] = list[i]
	end
	
	return copy
end

function List.deepCopy(list)
	local copy = {}

	for i = 1, #list do
		if type(list[i]) == "table" then
			copy[i] = Dictionary.deepCopy(list[i])
		else
			copy[i] = list[i]
		end
	end
	
	return copy
end

function List.filter(list, filterer)
	local filtered = {}

	local index = 1

	for i = 1, #list do
		if filterer(list[i]) then
			filtered[index] = list[i]
			index = index + 1
		end
	end
	
	return filtered
end

function List.map(list, mapper)
	local mapped = {}

	for i = 1, #list do
		mapped[i] = mapper(list[i])
	end
	
	return mapped
end

function List.filterMap(list, filterMapper)
	local filterMapped = {}

	local index = 1

	for i = 1, #list do
		local value = filterMapper(list[i])

		if value ~= nil then
			filterMapped[index] = value
			index = index + 1
		end
	end
	
	return filterMapped
end

function List.find(list, value)
	for i = 0, #list do
		if list[i] == value then
			return list[i]
		end
	end
end

function List.findFrom(list, from, value)
	for i = from, #list do
		if list[i] == value then
			return list[i]
		end
	end
end

function List.findLast(list, value)
	for i = #list, 1, -1 do
		if list[i] == value then
			return list[i]
		end
	end
end

function List.findLastFrom(list, from, value)
	for i = from, 1, -1 do
		if list[i] == value then
			return list[i]
		end
	end
end

function List.findWhere(list, predicate)
	for i = 1, #list do
		if predicate(list[i], i) then
			return list[i]
		end
	end
end

function List.findWhereFrom(list, from, predicate)
	for i = from, #list do
		if predicate(list[i], i) then
			return list[i]
		end
	end
end

function List.findWhereLast(list, predicate)
	for i = #list, 1, -1 do
		if predicate(list[i], i) then
			return list[i]
		end
	end
end

function List.findWhereLastFrom(list, from, predicate)
	for i = from, 1, -1 do
		if predicate(list[i], i) then
			return list[i]
		end
	end
end

function List.toSet(list)
	local set = {}

	for i = 1, #list do
		set[list[i]] = true
	end
	
	return set
end

function List.reverse(list)
	local reversed = {}

	local len = #list
	local back = len + 1

	for i = 1, len do
		reversed[back - i] = list[i]
	end
	
	return reversed
end

function List.sort(list, sorter)
	return table.sort(List.deepCopy(list), sorter)
end

function List.removeIndex(list, index)
	local result = {}
	local removedValue

	local resultIndex = 1

	for i = 1, #list do
		if i == index then
			removedValue = list[i]
		else
			result[resultIndex] = list[i]
			resultIndex = resultIndex + 1
		end
	end

	return result, removedValue
end

-- Removes all elements in range [from, to)
function List.removeRange(list, from, to)
	local result = {}
	local removedValues = {}

	local resultIndex = 1
	local removedIndex = 1

	for i = 1, #list do
		if i >= from and i < to then
			removedValues[removedIndex] = list[i]
			removedIndex = removedIndex + 1
		else
			result[resultIndex] = list[i]
			resultIndex = resultIndex + 1
		end
	end
	
	return result, removedValues
end

function List.removeValue(list, value)
	local result = {}
	local removedIndices = {}

	local resultIndex = 1
	local removedIndex = 1

	for i = 1, #list do
		if list[i] == value then
			removedIndices[removedIndex] = i
			removedIndex = removedIndex + 1
		else
			result[resultIndex] = list[i]
			resultIndex = resultIndex + 1
		end
	end
	
	return result, removedIndices
end

function List.removeValues(list, values)
	local result = {}
	local removedIndices = {}

	local remove = List.toSet(values)

	local resultIndex = 1
	local removedIndex = 1

	for i = 1, #list do
		if remove[list[i]] then
			removedIndices[removedIndex] = i
			removedIndex = removedIndex + 1
		else
			result[resultIndex] = list[i]
			resultIndex = resultIndex + 1
		end
	end
	
	return result, removedIndices
end

function List.set(list, index, value)
	local result = {}
	local replacedValue

	for i = 1, #list do
		if i == index then
			replacedValue = list[i]
			result[i] = value
		else
			result[i] = list[i]
		end
	end
	
	return result, replacedValue
end

function List.insertValue(list, index, insertion)
	local result = {}

	local resultIndex = 1

	for i = 1, #list do
		if i == index then
			result[resultIndex] = insertion
			resultIndex = resultIndex + 1
		end

		result[resultIndex] = list[i]
		resultIndex = resultIndex + 1
	end
	
	return result
end

function List.insertList(list, index, insertion)
	local result = {}

	local resultIndex = 1

	for i = 1, #list do
		if i == index then
			for j = 1, #insertion do
				result[resultIndex] = insertion[j]
				resultIndex = resultIndex + 1
			end
		end
		
		result[resultIndex] = list[i]
		resultIndex = resultIndex + 1
	end
	
	return result
end

function List.subList(list, from, to)
	local result = {}

	local index = 1

	for i = from, to do
		result[index] = list[i]
		index = index + 1
	end

	return result
end

llama.Dictionary = Dictionary
llama.List = List

return llama