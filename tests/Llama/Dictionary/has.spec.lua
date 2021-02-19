return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local has = Dictionary.has

	it("should validate types", function()
		local args = {
			{ 0 },
			{ 0, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				has(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a boolean", function()
		local a = {}

		expect(has(a, 1)).to.be.a("boolean")
	end)

	it("should return whether table has key or not", function()
		local a = {
			foo = "oof",
			bar = "rab",
			baz = "zab"
		}

		expect(has(a, "foo")).equal(true)
		expect(has(a, "oof")).equal(false)
	end)
end