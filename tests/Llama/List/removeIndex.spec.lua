return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local List = Llama.List
	local removeIndex = List.removeIndex

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 1.5 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				removeIndex(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(removeIndex(a, 1)).never.to.equal(a)
	end)

	it("should not passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		removeIndex(a, 1)

		expect(mutations).to.equal(0)
	end)

	it("should remove the element at the given index", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}

		local b = removeIndex(a, 2)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal("foo")
		expect(b[2]).to.equal("baz")
	end)

	it("should accept a 0 or negative index", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}

		local b = removeIndex(a, -1)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal("foo")
		expect(b[2]).to.equal("baz")
	end)

	it("should work with a None element", function()
		local a = {
			"foo",
			None,
			"baz"
		}

		local b = removeIndex(a, 1)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal(None)
		expect(b[2]).to.equal("baz")
	end)
end