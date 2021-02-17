return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local set = Dictionary.set

	it("should return a new table", function()
		local a = {}

		expect(set(a, "")).never.to.equal(a)
	end)

	it("should not mutate the given table", function()
		local a = {
			foo = "foo",
			bar = "bar",
			baz = "baz"
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		set(a, "baz", "boot")

		expect(mutations).to.equal(0)
	end)

	it("should set value at specified key", function()
		local a = {
			foo = "foo",
			bar = "bar",
		}

		local b = set(a, "bar", "boot")

		expect(b.bar).to.equal("boot")
	end)
end