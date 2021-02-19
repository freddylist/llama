return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local flatten = Dictionary.flatten

	it("should validate types", function()
		local _, err = pcall(function()
			flatten(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(flatten(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		flatten(a)

		expect(mutations).to.equal(0)
	end)

	it("should flatten the given table", function()
		local a = {
			foo = {
				bar = 1,
				baz = 2,
			},
			oof = {
				rab = 3,
				zab = 4,
			}
		}

		local b = flatten(a)

		expect(b.bar).to.equal(a.foo.bar)
		expect(b.baz).to.equal(a.foo.baz)
		expect(b.rab).to.equal(a.oof.rab)
		expect(b.zab).to.equal(a.oof.zab)
		expect(b.foo).never.to.be.ok()
		expect(b.oof).never.to.be.ok()
	end)

	it("should keep higher level entries", function()
		local a = {
			foo = 1,
			bar = {
				foo = 2,
			},
		}

		local b = flatten(a)

		expect(b.foo).to.equal(1)
	end)

	it("should flatten completely", function()
		local a = {
			foo = 1,
			foobar = {
				bar = 2,
				barbaz = {
					baz = 3,
					bazqux = {
						qux = 4,
					}
				}
			},
		}

		local b = flatten(a)

		expect(b.foo).to.equal(1)
		expect(b.bar).to.equal(2)
		expect(b.baz).to.equal(3)
		expect(b.qux).to.equal(4)
		expect(b.foobar).never.to.be.ok()
		expect(b.barbaz).never.to.be.ok()
		expect(b.bazqux).never.to.be.ok()
	end)

	it("should work with an empty table", function()
		local a = {}
		local b = flatten(a)

		expect(b).to.be.a("table")
	end)
end