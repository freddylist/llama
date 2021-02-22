return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local find = List.find

	it("should validate types", function()
		local _, err = pcall(function()
			find(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return the correct index", function()
		local a = { 5, 4, 3, 2, 1 }

		expect(find(a, 1)).to.equal(5)
		expect(find(a, 2)).to.equal(4)
		expect(find(a, 3)).to.equal(3)
		expect(find(a, 4)).to.equal(2)
		expect(find(a, 5)).to.equal(1)
	end)

	it("should return nil when the given value is not found", function()
		local a = { 1, 2, 3 }

		expect(find(a, 4)).never.to.be.ok()
		expect(type(find(a, 4))).to.equal("nil")
	end)

	it("should work with an empty table", function()
		expect(find({}, 1)).never.to.be.ok()
	end)

	it("should return the index of the first value found", function()
		local a = {1, 2, 2}

		expect(find(a, 2)).to.equal(2)
	end)

	it("should return the index of the first value found from start index", function()
		local a = { 1, 3, 3, 2, 3, 3, 2 }

		expect(find(a, 2, 5)).to.equal(7)
	end)

	it("should accept a 0 or negative start index", function()
		local a = { 1, 3, 3, 2, 3, 3, 2 }

		expect(find(a, 2, -5)).to.equal(4)
		expect(find(a, 2, 0)).to.equal(7)
	end)
end