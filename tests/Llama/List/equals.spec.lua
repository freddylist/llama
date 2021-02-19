return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local equals = List.equals

	it("should return a boolean", function()
		local a = {}

		expect(equals(a, a)).to.be.a("boolean")
		expect(equals(a, {})).to.be.a("boolean")
		expect(equals({}, { 1 })).to.be.a("boolean")
	end)

	it("should return whether provided tables have value equality or not", function()
		local a = {
			"foo",
			"bar",
			"baz",
			{},
		}
		local b = {
			"foo",
			"bar",
			"baz",
			a[4],
		}
		local c = {
			"foo",
			"bar",
			"baz",
			{},
		}

		expect(equals(a, b)).to.equal(true)
		expect(equals(a, c)).to.equal(false)
	end)

	it("should work with an arbitrary number of tables", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}
		local b = a
		local c = {
			"foo",
			"bar",
			"baz",
		}
		local d = {
			"oof",
			"rab",
			"zab",
		}
		local e = d
		local f = {
			"oof",
			"rab",
			"zab",
		}

		expect(equals(a, b, c)).to.equal(true)
		expect(equals(a, b, c, d, e, f)).to.equal(false)
	end)

	it("should work with one table", function()
		local a = {}

		expect(equals(a)).to.equal(true)
	end)

	it("should work with zero tables", function()
		expect(equals()).to.equal(true)
	end)

	it("should work for any type of objects", function()
		expect(equals(1, 1)).to.equal(true)
		expect(equals(1, "a")).to.equal(false)
	end)
end