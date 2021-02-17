return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local equalsDeep = Dictionary.equalsDeep

	it("should return a boolean", function()
		local a = {}
		local b = {}

		expect(equalsDeep(a, b)).to.be.a("boolean")
	end)

	it("should return whether provided tables and subtables have value equality or not", function()
		local a = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
			sub = {
				bob = "avocado",
			},
		}
		local b = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
			sub = {
				bob = "avocado",
			},
		}
		local c = {
			oof = "foo",
			rab = "bar",
			baz = "zab",
			sub = {
				bob = "avocado",
			},
		}

		expect(equalsDeep(a, b)).to.equal(true)
		expect(equalsDeep(a, c)).to.equal(false)
	end)

	it("should work with multiple subtables", function()
		local a = {
			sub = {
				bus = {
					hi = "hello"
				}
			}
		}
		local b = {
			sub = {
				bus = {
					hi = "hello"
				}
			}
		}

		expect(equalsDeep(a, b)).to.equal(true)
	end)

	it("should work with an arbitrary number of tables", function()
		local a = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
			yeet = {
				"delete",
			},
		}
		local b = a
		local c = {
			foo = "foo",
			bar = "bar",
			baz = "baz",
			yeet = {
				"delete",
			},
		}
		local d = {
			oof = "foo",
			rab = "bar",
			baz = "zab",
			badger = {
				badger = {
					badger = {
						mushroom = "yes",
					},
				},
			},
		}
		local e = d
		local f = {
			oof = "foo",
			rab = "bar",
			baz = "zab",
			badger = {
				badger = {
					badger = {
						mushroom = "yes",
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