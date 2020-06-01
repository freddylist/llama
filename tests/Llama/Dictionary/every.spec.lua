return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local every = Dictionary.every

	it("should return a boolean", function()
		local function always(bool)
			return function()
				return bool
			end
		end

		expect(every({}, always(true))).to.be.a("boolean")
		expect(every({}, always(false))).to.be.a("boolean")
	end)

	it("should pass the value and key to the predicate", function()
		local a = {
			foo = "bar",
		}

		local function predicate(v, k)
			expect(v).to.equal(a.foo)
			expect(k).to.equal("foo")
		end

		every(a, predicate)
	end)

	it("should return true if every entry passes the predicate", function()
		local a = {
			foo = "a",
			baz = "a",
			foobar = "a",
		}

		local function aOnly(v)
			return v == "a"
		end

		expect(every(a, aOnly)).to.equal(true)
	end)

	it("should return false if not all entries pass the predicate", function()
		local a = {
			foo = "a",
			baz = "a",
			foobar = "a",
			frob = "b"
		}

		local function aOnly(v)
			return v == "a"
		end

		expect(every(a, aOnly)).to.equal(false)
	end)
end