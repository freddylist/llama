return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local includes = List.includes

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
		expect(includes(a, "yeet")).to.equal(false)
	end)
end