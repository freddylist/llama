return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local findLast = List.findLast

	it("should return the correct index", function()
		local a = {5, 4, 3, 2, 1}

		expect(findLast(a, 1)).to.equal(5)
		expect(findLast(a, 2)).to.equal(4)
		expect(findLast(a, 3)).to.equal(3)
		expect(findLast(a, 4)).to.equal(2)
		expect(findLast(a, 5)).to.equal(1)
	end)

	it("should work with an empty table", function()
		expect(findLast({}, 1)).to.equal(nil)
	end)

	it("should return nil when the given value is not found", function()
		local a = {1, 2, 3}

		expect(findLast(a, 4)).to.equal(nil)
		expect(type(findLast(a, 4))).to.equal("nil")
	end)

	it("should return the index of the last value found", function()
		local list = {1, 2, 2}

		expect(findLast(list, 2)).to.equal(3)
	end)

	it("should return the index of the last value found from start index if provided", function()
		local list = {1, 3, 3, 2, 3, 3, 2}

		expect(findLast(list, 2, 5)).to.equal(4)
	end)
end