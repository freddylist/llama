return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local count = List.count

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
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

	it("should provide an accurate number of elements without a provided predicate", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}

		expect(count(a)).to.equal(3)
	end)

	it("should provide an accurate number of elements with provided predicate", function()
		local a = {
			"foo",
			"bar",
			"baz",
			"bar",
		}

		local function onlyBar(v)
			return string.find(v, "bar")
		end

		expect(count(a, onlyBar)).to.equal(2)
	end)

	it("should provide each value and index to the predicate", function()
		local a = {
			"foo",
		}

		local function predicate(v, i)
			expect(v).to.equal(a[1])
			expect(i).to.equal(1)
		end

		count(a, predicate)
	end)

	it("should call the predicate for each value", function()
		local a = {
			"foo",
			"bar",
			"baz",
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