return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local Dictionary = Llama.Dictionary
	local merge = Dictionary.merge

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				merge(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		expect(merge(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local mutationsA = 0
		local mutationsB = 0

		local a = {}
		local b = {
			foo = "foo-b",
		}

		setmetatable(a, {
			__newindex = function()
				mutationsA = mutationsA + 1
			end,
		})

		setmetatable(b, {
			__newindex = function()
				mutationsB = mutationsB + 1
			end,
		})

		merge(a, b)

		expect(mutationsA).to.equal(0)
		expect(mutationsB).to.equal(0)
	end)

	it("should merge tables, overwriting previous values", function()
		local a = {
			foo = "foo-a",
			bar = "bar-a",
		}

		local b = {
			foo = "foo-b",
			baz = "baz-b",
		}

		local c = merge(a, b)

		expect(c.foo).to.equal(b.foo)
		expect(c.bar).to.equal(a.bar)
		expect(c.baz).to.equal(b.baz)
	end)

	it("should remove None values", function()
		local a = {
			foo = "foo-a",
		}

		local b = {
			foo = None,
		}

		local c = merge(a, b)

		expect(c.foo).never.to.be.ok()
	end)

	it("should accept arbitrary numbers of tables", function()
		local a = {
			foo = "foo-a",
		}

		local b = {
			bar = "bar-b",
		}

		local c = {
			baz = "baz-c",
		}

		local d = merge(a, b, c)

		expect(d.foo).to.equal(a.foo)
		expect(d.bar).to.equal(b.bar)
		expect(d.baz).to.equal(c.baz)
	end)

	it("should accept zero tables", function()
		expect(merge()).to.be.a("table")
	end)

	it("should accept holes in arguments", function()
		local a = {
			foo = "foo-a",
		}

		local b = {
			bar = "bar-b",
		}

		local c = merge(a, nil, b)

		expect(c.foo).to.equal(a.foo)
		expect(c.bar).to.equal(b.bar)

		local d = merge(nil, a, b)

		expect(d.foo).to.equal(a.foo)
		expect(d.bar).to.equal(b.bar)
	end)
end