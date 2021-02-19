return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)
	local isEmpty = Llama.isEmpty

	it("should return a boolean", function()
		expect(isEmpty({ })).to.be.a("boolean")
		expect(isEmpty({ 1 })).to.be.a("boolean")
	end)

	it("should return true for empty tables", function()
		expect(isEmpty({ })).to.equal(true)
	end)

	it("should return false for not empty tables", function()
		local dictionary = {
			foo = 1,
			bar = 2,
		}

		expect(isEmpty({ 1, 2, 3 })).to.equal(false)
		expect(isEmpty(dictionary)).to.equal(false)
	end)
end