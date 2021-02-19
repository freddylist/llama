return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local set = Dictionary.set

	it("should validate types", function()
		local args = {
			{ 0 },
			{ 0, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				set(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		expect(set(a, "foo", 1)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		set(a, "qux", 4)

		expect(mutations).to.equal(0)
	end)

	it("should set value at specified key", function()
		local a = {
			foo = 1,
			bar = 2,
		}

		local b = set(a, "baz", 3)

		expect(b.baz).to.equal(3)
	end)
end