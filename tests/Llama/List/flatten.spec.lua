return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local flatten = List.flatten

	it("should return a new table", function()
		local a = {}

		expect(flatten(a)).never.to.equal(a)
	end)

	it("should not mutate the given table", function()
		local a = {
			"foo",
			{
				"bar",
				"baz"
			}
		}

		flatten(a)

		expect(a[2][1]).to.equal("bar")
		expect(a[2][2]).to.equal("baz")
		expect(a[3]).to.equal(nil)
	end)

	it("should flatten the given table", function()
		local bumpy = {
			{
				"hi",
				"hello",
			}, {
				"oof",
				"baz",
			}
		}
		local flattened = {
			"hi",
			"hello",
			"oof",
			"baz",
		}

		local b = flatten(bumpy)

		for k, v in pairs(b) do
			expect(v).to.equal(flattened[k])
		end
	end)

	it("should spread out elements", function()
		local a = {
			"foo",
			{
				"baz",
				"foobar",
			}, {
				"bar",
				"zab",
			},
			"zub",
		}
		local flattened = {
			"foo",
			"baz",
			"foobar",
			"bar",
			"zab",
			"zub",
		}

		local b = flatten(a, function(v)
			return v
		end)

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

		local b = flatten(a, function(v)
			return v
		end)

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