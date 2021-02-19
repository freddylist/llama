return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Set = Llama.Set
	local isSubset = Set.isSubset

	it("should validate types", function()
		local _, err = pcall(function()
			isSubset(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a boolean", function()
		expect(isSubset({}, {})).to.be.a("boolean")
	end)

	it("should return whether table is subset or not", function()
		local a = {
			foo = true,
			bar = true,
			baz = true,
		}
		local b = {
			foo = true,
			bar = true,
		}

		expect(isSubset(a, b)).equal(false)
		expect(isSubset(b, a)).equal(true)
	end)
end