return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local equalsDeep = List.equalsDeep

	it("should return a boolean", function()
		local a = {}
		local b = {}

		expect(equalsDeep(a, b)).to.be.a("boolean")
	end)

	it("should return whether provided tables and subtables have value equality or not", function()
		local a = {
			"foo",
			"bar",
			"baz",
			{
				bob = "avocado",
			},
		}
		local b = {
			"foo",
			"bar",
			"baz",
			{
				bob = "avocado",
			},
		}
		local c = {
			"foo",
			"bar",
			"zab",
			{
				bob = "avocado",
			},
		}

		expect(equalsDeep(a, b)).to.equal(true)
		expect(equalsDeep(a, c)).to.equal(false)
	end)

	it("should work with multiple subtables", function()
		local a = {
			{
				{
					"hello"
				}
			}
		}
		local b = {
			{
				{
					"hello"
				}
			}
		}

		expect(equalsDeep(a, b)).to.equal(true)
	end)

	it("should work with an arbitrary number of tables", function()
		local a = {
			"foo",
			"bar",
			"baz",
			{
				"yeet",
			},
		}
		local b = a
		local c = {
			"foo",
			"bar",
			"baz",
			{
				"yeet",
			},
		}
		local d = {
			"foo",
			"bar",
			"zab",
			{
				{
					{
						"yes",
					},
				},
			},
		}
		local e = d
		local f = {
			"foo",
			"bar",
			"zab",
			{
				{
					{
						"yes",
					},
				},
			},
		}

		expect(equalsDeep(a, b, c)).to.equal(true)
		expect(equalsDeep(d, e, f)).to.equal(true)
		expect(equalsDeep(a, b, c, d, e, f)).to.equal(false)
	end)

	it("should work with one table", function()
		local a = {}

		expect(equalsDeep(a)).to.equal(true)
	end)

	it("should work with zero tables", function()
		expect(equalsDeep()).to.equal(true)
	end)
end