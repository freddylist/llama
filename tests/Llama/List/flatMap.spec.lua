return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local flatMap = List.flatMap

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				flatMap(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		expect(flatMap(a, function(v)
			return v
		end)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		flatMap(a, function() end)

		expect(mutations).to.equal(0)
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
		local a = {
			{
				"foo",
				"bar",
			}, {
				"baz",
				"qux",
			}
		}

		local b = flatMap(a, function()
			return "oof"
		end)

		for k, v in pairs(b) do
			expect(v).to.equal("oof")
			expect(k).to.be.a("number")
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

	it("should work with an empty a", function()
		local a = {}
		local b = flatMap(a, function() end)

		expect(b).to.be.a("table")
		expect(b).never.to.equal(a)
	end)
end