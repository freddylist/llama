return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local flatMap = Dictionary.flatMap

	it("should return a new table", function()
		local a = {}

		expect(flatMap(a, function(v)
			return v
		end)).never.to.equal(a)
	end)

	it("should not mutate the given table", function()
		local a = {
			foo = "foo",
			foobar = {
				bar = "bar",
				baz = "baz"
			}
		}

		flatMap(a, function(v)
			return v
		end)

		expect(a.foobar.bar).to.equal("bar")
		expect(a.foobar.baz).to.equal("baz")
		expect(a.bar).to.equal(nil)
		expect(a.baz).to.equal(nil)
	end)

	it("should call the callback for each element", function()
		local a = {
			foo = "foo", 
			bar = "bar", 
			baz = "baz",
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
			foo = "foo", 
			bar = "bar", 
			baz = "baz",
		}
		local b = flatMap(a, function(v)
			return v .. "bar"
		end)

		for k, v in pairs(b) do
			expect(a[k] .. "bar").to.equal(v)
		end
	end)

	it("should remove values when nil is returned", function()
		local a = {
			foo = "foo", 
			bar = "bar", 
			baz = "baz",
		}
		local b = flatMap(a, function()
			return nil
		end)

		expect(#b).to.equal(0)
	end)

	it("should map and flatten the given table", function()
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

		local b = flatMap(bumpy, function()
			return "no"
		end)

		expect(b.foo).to.equal("no")
		expect(b.bar).to.equal("no")
		expect(b.oof).to.equal("no")
		expect(b.baz).to.equal("no")
		expect(b.bump1).to.equal(nil)
		expect(b.bump2).to.equal(nil)
	end)

	it("should keep higher entries", function()
		local a = {
			baz = "hi",
			bar = {
				baz = "hello"
			},
		}

		local b = flatMap(a, function(v)
			return v
		end)

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

		local b = flatMap(a, function(v)
			return v
		end)

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
		local b = flatMap(a, function() end)

		expect(b).to.be.a("table")
		expect(b).never.to.equal(a)
	end)
end