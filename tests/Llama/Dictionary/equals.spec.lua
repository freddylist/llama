return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local equals = Dictionary.equals

	it("should return a boolean", function()
		local a = {}
		local b = {}

		expect(equals(a, b)).to.be.a("boolean")
	end)

	it("should return whether provided tables have value equality or not", function()
		local a = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
			bob = {},
		}
		local b = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
			bob = a.bob,
		}
		local c = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
			bob = {},
		}

		expect(equals(a, b)).to.equal(true)
		expect(equals(a, c)).to.equal(false)
	end)

	it("should work with an arbitrary number of tables", function()
		local a = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
		}
		local b = a
		local c = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
		}
		local d = {
			oof = "foo",
			rab = "bar",
			baz = "zab",
		}
		local e = d
		local f = {
			oof = "foo",
			rab = "bar",
			baz = "zab",
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
end