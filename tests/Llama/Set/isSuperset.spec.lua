return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Set = Llama.Set
	local isSuperset = Set.isSuperset

	it("should validate types", function()
		local _, err = pcall(function()
			isSuperset(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a boolean", function()
		expect(isSuperset({}, {})).to.be.a("boolean")
	end)

	it("should return whether table is superset or not", function()
		local a = {
			foo = true,
			bar = true,
			baz = true,
		}
		local b = {
			foo = true,
			bar = true,
		}

		expect(isSuperset(a, b)).equal(true)
		expect(isSuperset(b, a)).equal(false)
	end)
end