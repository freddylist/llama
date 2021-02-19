return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local toSet = List.toSet

	it("should validate types", function()
		local _, err = pcall(function()
			toSet(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(toSet(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		toSet(a)

		expect(mutations).to.equal(0)
	end)

	it("should have every value in a as a key mapped to true in b", function()
		local a = {1, 2, 3, "a", "b", "c"}
		local b = toSet(a)

		expect(#b).to.equal(3)
		expect(b[1]).to.equal(true)
		expect(b[2]).to.equal(true)
		expect(b[3]).to.equal(true)

		expect(b[4]).never.to.be.ok()

		expect(b["a"]).to.equal(true)
		expect(b["b"]).to.equal(true)
		expect(b["c"]).to.equal(true)
	end)
end