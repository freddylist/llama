return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local findWhereLast = List.findWhereLast

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				findWhereLast(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

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

	it("should return nil when the when no value satisfies the predicate", function()
		local numbers = { 1, 2, 3 }
		
		local isFour = function(value)
			return value == 4
		end

		expect(findWhereLast(numbers, isFour)).never.to.be.ok()
	end)

	it("should work with an empty table", function()
		local anything = function()
			return true
		end

		expect(findWhereLast({}, anything)).never.to.be.ok()
	end)

	it("should return the index of the last value for which the predicate is true", function()
		local a = { 1, 1, 1, 2, 2 }

		local isTwo = function(value)
			return value == 2
		end

		expect(findWhereLast(a, isTwo)).to.equal(5)
	end)

	it("should return the index of the last value for which the predicate is true from start index", function()
		local a = { 1, 1, 1, 2, 2 }

		local isTwo = function(value)
			return value == 2
		end

		expect(findWhereLast(a, isTwo, 4)).to.equal(4)
	end)

	it("should accept a 0 or negative start index", function()
		local a = { 1, 3, 3, 2, 3, 3, 2 }

		local isTwo = function(value)
			return value == 2
		end

		expect(findWhereLast(a, isTwo, -1)).to.equal(4)
		expect(findWhereLast(a, isTwo, 0)).to.equal(7)
	end)

	it("should allow access to both value and index in the predicate function", function()
		local a = { 1, 1, 2, 2, 1 }

		local sumValueAndIndexToFive = function(value, index)
			return value + index == 5
		end

		expect(findWhereLast(a, sumValueAndIndexToFive)).to.equal(3)
	end)
end