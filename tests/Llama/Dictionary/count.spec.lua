return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local count = Dictionary.count

	it("should return a number", function()
		expect(count({})).to.be.a("number")
	end)

	it("should provide an accurate number of elements without a provided predicate", function()
		local a = {
			banana = "avocado",
			apple = "grape",
			pineapple = "cucumber",
		}

		expect(count(a)).to.equal(3)
	end)

	it("should provide an accurate number of elements with provided predicate", function()
		local a = {
			banana = "avocado",
			apple = "grape",
			pineapple = "cucumber",
			peach = "grape",
		}

		local function grapesOnly(v)
			return string.find(v, "grape")
		end

		expect(count(a, grapesOnly)).to.equal(2)
	end)

	it("should provide each value and key to the predicate", function()
		local a = {
			banana = "avocado",
		}

		local function predicate(v, k)
			expect(v).to.equal(a.banana)
			expect(k).to.equal("banana")
		end

		count(a, predicate)
	end)

	it("should call the predicate for each value", function()
		local a = {
			banana = "avocado",
			apple = "grape",
			pineapple = "cucumber",
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