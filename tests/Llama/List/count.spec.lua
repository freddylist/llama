return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local count = List.count

	it("should return a number", function()
		expect(count({})).to.be.a("number")
	end)

	it("should provide an accurate number of elements without a provided predicate", function()
		local a = {
			"avocado",
			"grape",
			"cucumber",
		}

		expect(count(a)).to.equal(3)
	end)

	it("should provide an accurate number of elements with provided predicate", function()
		local a = {
			"avocado",
			"grape",
			"cucumber",
			"grape",
		}

		local function grapesOnly(v)
			return string.find(v, "grape")
		end

		expect(count(a, grapesOnly)).to.equal(2)
	end)

	it("should provide each value and index to the predicate", function()
		local a = {
			"avocado",
		}

		local function predicate(v, i)
			expect(v).to.equal(a[1])
			expect(i).to.equal(1)
		end

		count(a, predicate)
	end)

	it("should call the predicate for each value", function()
		local a = {
			"avocado",
			"grape",
			"cucumber",
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