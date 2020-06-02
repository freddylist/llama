return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local flatMap = List.flatMap

	it("should return a new table", function()
		local a = {}

		expect(flatMap(a, function(v)
			return v
		end)).never.to.equal(a)
	end)

	it("should not mutate the given table", function()
		local a = {
			"foo",
			{
				"bar",
				"baz"
			}
		}

		flatMap(a, function(v)
			return v
		end)

		expect(a[2][1]).to.equal("bar")
		expect(a[2][2]).to.equal("baz")
		expect(a[3]).to.equal(nil)
	end)

	it("should call the callback for each element", function()
		local a = {
			"foo", 
			"bar",
			"baz",
		}
		local called = 0

		flatMap(a, function(v)
			called = called + 1
			return v
		end)

		expect(called).to.equal(3)
	end)

	it("should set the new values to the result of the given callback", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}
		local b = flatMap(a, function(v)
			return v .. "bar"
		end)

		for k, v in pairs(b) do
			expect(a[k] .. "bar").to.equal(v)
		end
	end)

	it("should remove values when nil is returned", function()
		local a = {
			"foo", 
			"bar", 
			"baz",
		}
		local b = flatMap(a, function()
			return nil
		end)

		expect(#b).to.equal(0)
	end)

	it("should map and flatten the given table", function()
		local bumpy = {
			{
				"hi",
				"hello",
			}, {
				"oof",
				"baz",
			}
		}

		local b = flatMap(bumpy, function()
			return "no"
		end)

		for k, v in pairs(b) do
			expect(v).to.equal("no")
			expect(k).to.be.a("number")
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

		local b = flatMap(a, function(v)
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

		local b = flatMap(a, function(v)
			return v
		end)

		for k, v in pairs(b) do
			expect(v).to.equal(flattened[k])
		end
	end)

	it("should work with an empty list", function()
		local a = {}
		local b = flatMap(a, function() end)

		expect(b).to.be.a("table")
		expect(b).never.to.equal(a)
	end)
end