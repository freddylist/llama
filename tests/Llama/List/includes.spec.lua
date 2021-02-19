return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local includes = List.includes

	it("should validate types", function()
		local _, err = pcall(function()
			includes(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a boolean", function()
		local a = {}

		expect(includes(a)).to.be.a("boolean")
	end)

	it("should return whether table has value or not", function()
		local a = {
			"foo",
			"bar",
			"baz"
		}

		expect(includes(a, "foo")).to.equal(true)
		expect(includes(a, "qux")).to.equal(false)
	end)
end