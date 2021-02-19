return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local flatMap = Dictionary.flatMap

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end }
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

		local function doNothing(v)
			return v
		end

		flatMap(a, doNothing)

		expect(mutations).to.equal(0)
	end)

	it("should call the callback for each element", function()
		local a = {
			foo = 1, 
			bar = 2, 
			baz = 3,
		}
		local copy = {}

		flatMap(a, function(v, index)
			copy[index] = v

			return v
		end)

		for k, v in pairs(a) do
			expect(copy[k]).to.equal(v)
		end

		for k, v in pairs(copy) do
			expect(v).to.equal(a[k])
		end
	end)

	it("should set the new values to the result of the given callback", function()
		local a = {
			foo = 1, 
			bar = 2,
			baz = 3,
		}

		local function double(v)
			return v * 2
		end

		local b = flatMap(a, double)

		for k, v in pairs(b) do
			expect(a[k] * 2).to.equal(v)
		end
	end)

	it("should remove values when nil is returned", function()
		local a = {
			foo = "foo", 
			bar = "bar", 
			baz = "baz",
		}

		local function nothing()
			return nil
		end

		local b = flatMap(a, nothing)

		expect(#b).to.equal(0)
	end)

	it("should map and flatten the given table", function()
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

		local function double(v)
			return v * 2
		end

		local b = flatMap(a, double)

		expect(b.bar).to.equal(double(a.foo.bar))
		expect(b.baz).to.equal(double(a.foo.baz))
		expect(b.rab).to.equal(double(a.oof.rab))
		expect(b.zab).to.equal(double(a.oof.zab))
		expect(b.foo).never.to.be.ok()
		expect(b.oof).never.to.be.ok()
	end)

	it("should keep higher level entries", function()
		local a = {
			foo = 1,
			bar = {
				foo = 2
			},
		}

		local b = flatMap(a, function(v)
			return v
		end)

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

		local function doNothing(v)
			return v
		end

		local b = flatMap(a, doNothing)

		expect(b.foo).to.equal(1)
		expect(b.bar).to.equal(2)
		expect(b.baz).to.equal(3)
		expect(b.qux).to.equal(4)
		expect(b.foobar).never.to.be.ok()
		expect(b.barbaz).never.to.be.ok()
		expect(b.bazqux).never.to.be.ok()
	end)

	it("should work with an empty list", function()
		local a = {}
		local b = flatMap(a, function() end)

		expect(b).to.be.a("table")
		expect(b).never.to.equal(a)
	end)
end