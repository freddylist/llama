return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local every = List.every

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end },
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
			"foo",
			"foo",
			"foo",
		}

		local function onlyFoo(v)
			return v == "foo"
		end

		expect(every(a, onlyFoo)).to.equal(true)
	end)

	it("should return false if not all entries pass the predicate", function()
		local a = {
			"foo",
			"foo",
			"bar",
		}

		local function onlyFoo(v)
			return v == "foo"
		end

		expect(every(a, onlyFoo)).to.equal(false)
	end)
end