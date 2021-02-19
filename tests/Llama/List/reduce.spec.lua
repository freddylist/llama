return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local reduce = List.reduce

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				reduce(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should call the reducer", function()
		local a = { 1, 2, 3 }
		local called = 0

		reduce(a, function()
			called = called + 1
		end, 0)

		expect(called).to.equal(3)
	end)

	it("should not call the reducer when the list is empty", function()
		local called = false

		reduce({}, function()
			called = true
		end)

		expect(called).to.equal(false)
	end)

	it("should call the reducer for each element", function()
		local a = { 4, 5, 6 }
		local copy = {}

		reduce(a, function(accum, value, index)
			copy[index] = value
			return accum
		end, 0)

		expect(#copy).to.equal(#a)

		for key, value in pairs(a) do
			expect(value).to.equal(copy[key])
		end
	end)

	it("should pass the same modified initial value to the reducer", function()
		local a = { 5, 4, 3 }
		local initialValue = {}

		reduce(a, function(accum)
			expect(accum).to.equal(initialValue)
			return accum
		end, initialValue)
	end)

	it("should call the reducer in the correct order", function()
		local a = { 5, 4, 3 }
		local index = 1

		reduce(a, function(accum, value)
			expect(value).to.equal(a[index])
			index = index + 1

			return accum
		end, 0)
	end)

	it("should accept a falsy initial reduction", function()
		local a = { 1, 2 }
		local result = reduce(a, function(acc)
			return acc
		end, false)

		expect(result).to.equal(false)
	end)

	it("should make the initial reduction the first value of the list if not provided", function()
		local a = { 1, 2, 3 }
		local called = 0

		local sum = reduce(a, function(accum, value)
			called = called + 1
			return accum + value
		end)

		expect(called).to.equal(2)
		expect(sum).to.equal(6)
	end)
end