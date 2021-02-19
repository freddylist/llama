return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local some = Dictionary.some

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end }
		}

		for i = 1, #args do
			local _, err = pcall(function()
				some(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a boolean", function()
		local function always(bool)
			return function()
				return bool
			end
		end

		expect(some({}, always(true))).to.be.a("boolean")
		expect(some({}, always(false))).to.be.a("boolean")
	end)

	it("should pass the value and key to the predicate", function()
		local a = {
			foo = 1,
		}

		local function predicate(v, k)
			expect(v).to.equal(a.foo)
			expect(k).to.equal("foo")
		end

		some(a, predicate)
	end)

	it("should return true if at least one entry passes the predicate", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}

		local function only1s(v)
			return v == 1
		end

		expect(some(a, only1s)).to.equal(true)
	end)

	it("should return false if no entries pass the predicate", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}

		local function only4s(v)
			return v == 4
		end

		expect(some(a, only4s)).to.equal(false)
	end)
end