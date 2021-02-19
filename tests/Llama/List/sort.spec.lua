return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local sort = List.sort

	it("should validate types", function()
		local _, err = pcall(function()
			sort(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(sort(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		sort(a)

		expect(mutations).to.equal(0)
	end)

	it("should contain the same elements from the given table", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}
		local elementSet = {
			foo = true,
			bar = true,
			baz = true,
		}
		local b = sort(a)

		expect(#b).to.equal(3)
		for _, value in ipairs(b) do
			expect(elementSet[value]).to.equal(true)
		end
	end)

	it("should sort with the default table.sort when no callback is given", function()
		local a = { 4, 2, 5, 3, 1 }
		local b = sort(a)

		table.sort(a)

		expect(#b).to.equal(#a)

		for i = 1, #a do
			expect(b[i]).to.equal(a[i])
		end
	end)

	it("should sort with the given callback", function()
		local a = { 1, 2, 5, 3, 4 }

		local function comparator(first, second)
			return first > second
		end

		local b = sort(a, comparator)

		table.sort(a, comparator)

		expect(#b).to.equal(#a)

		for i = 1, #a do
			expect(b[i]).to.equal(a[i])
		end
	end)

	it("should work with an empty table", function()
		local a = sort({})

		expect(#a).to.equal(0)
	end)
end