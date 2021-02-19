return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local every = Dictionary.every

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end }
		}

		for i = 1, #args do
			local _, err = pcall(function()
				every(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a boolean", function()
		local function always(value)
			return function()
				return value
			end
		end

		expect(every({}, always(true))).to.be.a("boolean")
		expect(every({}, always(false))).to.be.a("boolean")
	end)

	it("should pass the value and key to the predicate", function()
		local a = {
			foo = 1,
		}

		local function predicate(v, k)
			expect(v).to.equal(a.foo)
			expect(k).to.equal("foo")
		end

		every(a, predicate)
	end)

	it("should return true if every entry passes the predicate", function()
		local a = {
			foo = 1,
			bar = 1,
			baz = 1,
		}

		local function only1s(v)
			return v == 1
		end

		expect(every(a, only1s)).to.equal(true)
	end)

	it("should return false if not all entries pass the predicate", function()
		local a = {
			foo = 1,
			bar = 1,
			baz = 1,
			qux = 2,
		}

		local function only1s(v)
			return v == 1
		end

		expect(every(a, only1s)).to.equal(false)
	end)
end