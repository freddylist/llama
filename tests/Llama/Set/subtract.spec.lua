return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Set = Llama.Set
	local subtract = Set.subtract

	it("should return a new table", function()
		local a = {}

		expect(subtract(a, "e")).never.to.equal(a)
	end)
	
	it("should not mutate the given table", function()
		local a = {
			foo = true,
			bar = true,
			baz = true,
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end
		})

		subtract(a, "foobar")

		expect(mutations).to.equal(0)
	end)

	it("should subtract provided entries", function()
		local a = {
			foo = true,
			bar = true,
			baz = true,
		}

		local b = subtract(a, "foo", "bar")

		expect(b.foo).to.equal(nil)
		expect(b.bar).to.equal(nil)
		expect(b.baz).to.equal(true)
	end)
end