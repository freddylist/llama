return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local List = Llama.List
	local removeIndices = List.removeIndices

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 1.5 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				removeIndices(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(removeIndices(a, 1)).never.to.equal(a)
	end)

	it("should not passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		removeIndices(a, 1)

		expect(mutations).to.equal(0)
	end)

	it("should remove elements at the given indices", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}

		local b = removeIndices(a, 2, 3)

		expect(#b).to.equal(1)
		expect(b[1]).to.equal("foo")
	end)

	it("should accept 0 or negative indices", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}

		local b = removeIndices(a, 0, -1)

		expect(#b).to.equal(1)
		expect(b[1]).to.equal("foo")
	end)

	it("should work with a None element", function()
		local a = {
			"foo",
			None,
			"baz"
		}

		local b = removeIndices(a, 1)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal(None)
		expect(b[2]).to.equal("baz")
	end)
end