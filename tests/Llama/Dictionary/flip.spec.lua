return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local flip = Dictionary.flip

	it("should return a new table", function()
		local a = {}
		local b = flip(a)

		expect(a).never.to.equal(b)
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
			end
		})

		flip(a)

		expect(mutations).to.equal(0)
	end)

	it("should flip keys and values", function()
		local a = {
			foo = 1,
			bar = "yeehaw",
			baz = "yeet",
			skeet = "yeet",
		}

		local b = flip(a)

		for k, v in pairs(b) do
			expect(k).to.equal(a[v])
		end
	end)
end