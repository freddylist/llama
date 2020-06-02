return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local get = Dictionary.get

	it("should get the value at the specified key", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}

		expect(get(a, "foo")).to.equal(1)
		expect(get(a, "yeet")).to.equal(nil)
	end)
end