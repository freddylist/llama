return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local count = Dictionary.count

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end }
		}

		for i = 1, #args do
			local _, err = pcall(function()
				count(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a number", function()
		expect(count({})).to.be.a("number")
	end)

	it("should return number of entries even without a predicate", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}

		expect(count(a)).to.equal(3)
	end)

	it("should return number of entries that pass given predicate", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
			qux = 3,
		}

		local function only3s(v)
			return v == 3
		end

		expect(count(a, only3s)).to.equal(2)
	end)

	it("should provide each value and key to the predicate", function()
		local a = {
			foo = 1,
		}

		local function predicate(v, k)
			expect(v).to.equal(a.foo)
			expect(k).to.equal("foo")
		end

		count(a, predicate)
	end)

	it("should call the predicate for each value", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}
		local callCount = 0

		local function counter()
			callCount = callCount + 1
		end

		count(a, counter)

		expect(callCount).to.equal(3)
	end)

	it("should work with empty tables", function()
		expect(count({})).to.equal(0)
	end)
end