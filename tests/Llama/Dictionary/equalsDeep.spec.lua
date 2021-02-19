return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local equalsDeep = Dictionary.equalsDeep

	it("should return a boolean", function()
		local a = {}

		expect(equalsDeep(a, a)).to.be.a("boolean")
		expect(equalsDeep(a, {})).to.be.a("boolean")
		expect(equalsDeep({}, { 1 })).to.be.a("boolean")
	end)

	it("should return whether provided tables have value equality", function()
		local a = {
			foo = 1,
			bar = 2,
			foobar = {
				baz = 3,
			},
		}
		local b = {
			foo = 1,
			bar = 2,
			foobar = {
				baz = 3,
			},
		}
		local c = {
			oof = 1,
			rab = 2,
			raboof = {
				zab = 3,
			},
		}

		expect(equalsDeep(a, b)).to.equal(true)
		expect(equalsDeep(a, c)).to.equal(false)
	end)

	it("should work with multiple levels of subtables", function()
		local a = {
			foo = {
				bar = {
					baz = "hi"
				}
			}
		}
		local b = {
			foo = {
				bar = {
					baz = "hi"
				}
			}
		}

		expect(equalsDeep(a, b)).to.equal(true)
	end)

	it("should work with an arbitrary number of tables", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = {
				3,
			},
		}
		local b = a
		local c = {
			foo = 1,
			bar = 2,
			baz = {
				3,
			},
		}
		local d = {
			oof = 1,
			rab = 2,
			zab = 3,
			badger = {
				badger = {
					badger = {
						mushroom = true,
					},
				},
			},
		}
		local e = d
		local f = {
			oof = 1,
			rab = 2,
			zab = 3,
			badger = {
				badger = {
					badger = {
						mushroom = true,
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