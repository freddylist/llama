return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local findWhereLast = List.findWhereLast

	it("should return the correct index", function()
		local numbers = { 1, 5, 10, 7 }

		local isEven = function(value)
			return value % 2 == 0
		end

		local isOdd = function(value)
			return value % 2 == 1
		end

		expect(findWhereLast(numbers, isEven)).to.equal(3)
		expect(findWhereLast(numbers, isOdd)).to.equal(4)
	end)

	it("should work with an empty table", function()
		local anything = function()
			return true
		end

		expect(findWhereLast({}, anything)).to.equal(nil)
	end)

	it("should return nil when the when no value satisfies the predicate", function()
		local numbers = { 1, 2, 3 }
		
		local isFour = function(value)
			return value == 4
		end

		expect(findWhereLast(numbers, isFour)).to.equal(nil)
	end)

	it("should return the index of the last value for which the predicate is true", function()
		local list = { 1, 1, 1, 2, 2 }

		local isTwo = function(value)
			return value == 2
		end

		expect(findWhereLast(list, isTwo)).to.equal(5)
	end)

	it("should return the index of the last value for which the predicate is true from start index if provided", function()
		local list = { 1, 1, 1, 2, 2 }

		local isTwo = function(value)
			return value == 2
		end

		expect(findWhereLast(list, isTwo, 4)).to.equal(4)
	end)

	it("should allow access to table index in the predicate function", function()
		local list = { 5, 4, 3, 2, 1 }

		local isIndexFour = function(_, index)
			return index == 4
		end

		expect(findWhereLast(list, isIndexFour)).to.equal(4)
	end)

	it("should allow access to both value and index in the predicate function", function()
		local list = { 1, 1, 2, 2, 1 }

		local sumValueAndIndexToFive = function(value, index)
			return value + index == 5
		end

		expect(findWhereLast(list, sumValueAndIndexToFive)).to.equal(3)
	end)
end