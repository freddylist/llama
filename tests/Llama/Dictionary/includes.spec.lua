return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local includes = Dictionary.includes

	it("should return a boolean", function()
		local a = {}

		expect(includes(a)).to.be.a("boolean")
	end)

	it("should return whether table has value or not", function()
		local a = {
			foo = "oof",
			bar = "rab",
			baz = "zab"
		}

		expect(includes(a, "oof")).to.equal(true)
		expect(includes(a, "yeet")).to.equal(false)
	end)
end