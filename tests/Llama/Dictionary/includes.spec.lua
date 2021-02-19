return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local includes = Dictionary.includes

	it("should validate types", function()
		local args = {
			{ 0 },
			{ 0, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				includes(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

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
		expect(includes(a, "foo")).to.equal(false)
	end)
end