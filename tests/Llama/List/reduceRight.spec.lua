return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local reduceRight = List.reduceRight

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				reduceRight(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should call the reducer", function()
		local a = { 1, 2, 3 }
		local called = 0

		reduceRight(a, function()
			called = called + 1
		end, 0)

		expect(called).to.equal(3)
	end)

	it("should not call the reducer when the list is empty", function()
		local called = false

		reduceRight({}, function()
			called = true
		end, 0)

		expect(called).to.equal(false)
	end)

	it("should call the reducer for each element", function()
		local a = { 4, 5, 6 }
		local copy = {}

		reduceRight(a, function(accum, value, index)
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

		reduceRight(a, function(accum)
			expect(accum).to.equal(initialValue)
			return accum
		end, initialValue)
	end)

	it("should call the reducer in the correct order", function()
		local a = { 5, 4, 3 }
		local index = 3

		reduceRight(a, function(accum, value)
			expect(value).to.equal(a[index])
			index = index - 1
			return accum
		end, 0)
	end)

	it("should accept a falsy initial reduction", function()
		local a = { 1, 2 }
		local result = reduceRight(a, function(acc)
			return acc
		end, false)
		expect(result).to.equal(false)
	end)

	it("should make the initial reduction the last value of the list if not provided", function()
		local a = { 1, 2, 3 }
		local called = 0

		local sum = reduceRight(a, function(accum, value)
			called = called + 1
			return accum + value
		end)

		expect(called).to.equal(2)
		expect(sum).to.equal(6)
	end)
end