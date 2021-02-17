return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local flatten = Dictionary.flatten

	it("should return a new table", function()
		local a = {}

		expect(flatten(a)).never.to.equal(a)
	end)

	it("should not mutate the given table", function()
		local a = {
			foo = "foo",
			foobar = {
				bar = "bar",
				baz = "baz"
			}
		}

		flatten(a)

		expect(a.foobar.bar).to.equal("bar")
		expect(a.foobar.baz).to.equal("baz")
		expect(a.bar).to.equal(nil)
		expect(a.baz).to.equal(nil)
	end)

	it("should flatten the given table", function()
		local bumpy = {
			bump1 = {
				foo = "hi",
				bar = "hello",
			},
			bump2 = {
				oof = "oof",
				baz = "baz",
			}
		}

		local b = flatten(bumpy)

		expect(b.foo).to.equal(bumpy.bump1.foo)
		expect(b.bar).to.equal(bumpy.bump1.bar)
		expect(b.oof).to.equal(bumpy.bump2.oof)
		expect(b.baz).to.equal(bumpy.bump2.baz)
		expect(b.bump1).to.equal(nil)
		expect(b.bump2).to.equal(nil)
	end)

	it("should keep higher entries", function()
		local a = {
			baz = "hi",
			bar = {
				baz = "hi"
			},
		}

		local b = flatten(a)

		expect(b.baz).to.equal("hi")
	end)

	it("should flatten completely", function()
		local a = {
			uno = 1,
			bar = {
				dos = 2,
				foo = {
					tres = 3,
					baz = {
						quatro = 4,
					}
				}
			},
		}

		local b = flatten(a)

		expect(b.uno).to.equal(1)
		expect(b.dos).to.equal(2)
		expect(b.tres).to.equal(3)
		expect(b.quatro).to.equal(4)
		expect(b.bar).to.equal(nil)
		expect(b.foo).to.equal(nil)
		expect(b.baz).to.equal(nil)
	end)

	it("should work with an empty list", function()
		local a = {}
		local b = flatten(a)

		expect(b).to.be.a("table")
		expect(b).never.to.equal(a)
	end)
end