return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local Set = Llama.Set
	local fromList = Set.fromList

	it("should validate types", function()
		local _, err = pcall(function()
			fromList(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(fromList(a)).never.to.equal(a)
	end)
	
	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end
		})

		fromList(a)

		expect(mutations).to.equal(0)
	end)

	it("should create a set from a list", function()
		local list = { "foo", "bar" }

		local set = fromList(list)

		expect(set.foo).to.equal(true)
		expect(set.bar).to.equal(true)
	end)

	it("should not skip None values", function()
		local list = { "foo", None }

		local set = fromList(list)

		expect(set.foo).to.equal(true)
		expect(set[None]).to.equal(true)
	end)
end