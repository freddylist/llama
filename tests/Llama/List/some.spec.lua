return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local some = List.some

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end},
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

	it("should pass the value and index to the predicate", function()
		local a = {
			"bar",
		}

		local function predicate(v, i)
			expect(v).to.equal(a[1])
			expect(i).to.equal(1)
		end

		some(a, predicate)
	end)

	it("should return true if at least one entry passes the predicate", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}

		local function onlyFoo(v)
			return v == "foo"
		end

		expect(some(a, onlyFoo)).to.equal(true)
	end)

	it("should return false if no entries pass the predicate", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}

		local function onlyQux(v)
			return v == "qux"
		end

		expect(some(a, onlyQux)).to.equal(false)
	end)
end