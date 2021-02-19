return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local reverse = List.reverse

	it("should validate types", function()
		local _, err = pcall(function()
			reverse(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(reverse(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		reverse(a)

		expect(mutations).to.equal(0)
	end)

	it("should contain the same elements", function()
		local a = {
			"foo",
			"bar"
		}
		local aSet = {
			foo = true,
			bar = true
		}
		local b = reverse(a)

		expect(#b).to.equal(2)

		for _, value in ipairs(b) do
			expect(aSet[value]).to.equal(true)
		end
	end)

	it("should reverse the list", function()
		local a = { 1, 2, 3, 4 }
		local b = reverse(a)

		expect(b[1]).to.equal(4)
		expect(b[2]).to.equal(3)
		expect(b[3]).to.equal(2)
		expect(b[4]).to.equal(1)
	end)
end