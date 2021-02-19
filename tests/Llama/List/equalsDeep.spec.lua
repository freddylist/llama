return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local equalsDeep = List.equalsDeep

	it("should return a boolean", function()
		local a = {}

		expect(equalsDeep(a, a)).to.be.a("boolean")
		expect(equalsDeep(a, {})).to.be.a("boolean")
		expect(equalsDeep({}, { 1 })).to.be.a("boolean")
	end)

	it("should return whether provided tables and subtables have value equality or not", function()
		local a = {
			"foo",
			"bar",
			{
				"baz",
			},
		}
		local b = {
			"foo",
			"bar",
			{
				"baz",
			},
		}
		local c = {
			"foo",
			"baz",
			{
				"baz",
			},
		}

		expect(equalsDeep(a, b)).to.equal(true)
		expect(equalsDeep(a, c)).to.equal(false)
	end)

	it("should work with multiple subtables", function()
		local a = {
			{
				{
					"hi"
				}
			}
		}
		local b = {
			{
				{
					"hi"
				}
			}
		}

		expect(equalsDeep(a, b)).to.equal(true)
	end)

	it("should work with an arbitrary number of tables", function()
		local a = {
			"foo",
			"bar",
			{
				"baz",
			},
		}
		local b = a
		local c = {
			"foo",
			"bar",
			{
				"baz",
			},
		}
		local d = {
			"foo",
			"bar",
			{
				{
					{
						"baz",
					},
				},
			},
		}
		local e = d
		local f = {
			"foo",
			"bar",
			{
				{
					{
						"baz",
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

	it("should work for any type of objects", function()
		expect(equalsDeep(1, 1)).to.equal(true)
		expect(equalsDeep(1, "a")).to.equal(false)
	end)
end