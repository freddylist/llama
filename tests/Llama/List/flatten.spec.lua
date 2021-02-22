return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local flatten = List.flatten

	it("should validate types", function()
		local _, err = pcall(function()
			flatten(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(flatten(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		flatten(a)

		expect(mutations).to.equal(0)
	end)

	it("should flatten the given table", function()
		local a = {
			{
				"foo",
				"bar",
			}, {
				"baz",
				"qux",
			}
		}
		local flattened = {
			"foo",
			"bar",
			"baz",
			"qux",
		}

		local b = flatten(a)

		for k, v in pairs(b) do
			expect(v).to.equal(flattened[k])
		end
	end)

	it("should spread out elements", function()
		local a = {
			"foo",
			{
				"bar",
				"baz",
			}, {
				"bar",
				"baz",
			},
			"qux",
		}
		local flattened = {
			"foo",
			"bar",
			"baz",
			"bar",
			"baz",
			"qux",
		}

		local b = flatten(a)

		for k, v in pairs(b) do
			expect(v).to.equal(flattened[k])
		end
	end)

	it("should flatten completely", function()
		local a = {
			1,
			{
				2,
				{
					3,
					{
						4,
					}
				}
			},
		}
		local flattened = {
			1,
			2,
			3,
			4,
		}

		local b = flatten(a)

		for k, v in pairs(b) do
			expect(v).to.equal(flattened[k])
		end
	end)

	it("should work with an empty list", function()
		local a = {}
		local b = flatten(a, function() end)

		expect(b).to.be.a("table")
		expect(b).never.to.equal(a)
	end)
end