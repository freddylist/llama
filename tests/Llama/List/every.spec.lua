return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local every = List.every

	it("should return a boolean", function()
		local function always(bool)
			return function()
				return bool
			end
		end

		expect(every({}, always(true))).to.be.a("boolean")
		expect(every({}, always(false))).to.be.a("boolean")
	end)

	it("should pass the value and index to the predicate", function()
		local a = {
			"bar",
		}

		local function predicate(v, i)
			expect(v).to.equal(a[i])
			expect(i).to.equal(1)
		end

		every(a, predicate)
	end)

	it("should return true if every entry passes the predicate", function()
		local a = {
			"a",
			"a",
			"a",
		}

		local function aOnly(v)
			return v == "a"
		end

		expect(every(a, aOnly)).to.equal(true)
	end)

	it("should return false if not all entries pass the predicate", function()
		local a = {
			"a",
			"a",
			"a",
			"b"
		}

		local function aOnly(v)
			return v == "a"
		end

		expect(every(a, aOnly)).to.equal(false)
	end)
end