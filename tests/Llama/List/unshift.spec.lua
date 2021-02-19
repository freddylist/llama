return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local unshift = List.unshift

	it("should validate types", function()
		local _, err = pcall(function()
			unshift(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(unshift(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		unshift(a, "baz")

		expect(mutations).to.equal(0)
	end)

	it("should add values to the beginning of provided list", function()
		local a = { 1, 2, 3 }
		local result = unshift(a, 4, 5, 6)

		expect(result[1]).to.equal(4)
		expect(result[2]).to.equal(5)
		expect(result[3]).to.equal(6)
		expect(result[4]).to.equal(1)
		expect(result[5]).to.equal(2)
		expect(result[6]).to.equal(3)
	end)
end