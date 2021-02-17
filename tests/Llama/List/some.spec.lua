return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local some = List.some

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
			"a",
			"b",
			"c",
		}

		local function aOnly(v)
			return v == "a"
		end

		expect(some(a, aOnly)).to.equal(true)
	end)

	it("should return false if no entries pass the predicate", function()
		local a = {
			"a",
			"a",
			"a",
			"b",
		}

		local function cOnly(v)
			return v == "c"
		end

		expect(some(a, cOnly)).to.equal(false)
	end)
end