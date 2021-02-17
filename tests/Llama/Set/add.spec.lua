return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Set = Llama.Set
	local add = Set.add

	it("should return a new table", function()
		local a = {}

		expect(add(a, "e")).never.to.equal(a)
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

		add(a, "foobar")

		expect(mutations).to.equal(0)
	end)

	it("should add provided entries", function()
		local a = {}

		local b = add(a, "foo", "bar", "baz")

		expect(b.foo).to.equal(true)
		expect(b.bar).to.equal(true)
		expect(b.baz).to.equal(true)
	end)
end