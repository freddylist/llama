return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Set = Llama.Set
	local has = Set.has

	it("should validate types", function()
		local _, err = pcall(function()
			has(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a boolean", function()
		local a = {}

		expect(has(a, "e")).to.be.a("boolean")
	end)

	it("should return whether table has key or not", function()
		local a = {
			foo = true,
			bar = true,
			baz = true,
		}

		expect(has(a, "foo")).equal(true)
		expect(has(a, "qux")).equal(false)
	end)
end