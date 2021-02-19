return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local Dictionary = Llama.Dictionary
	local fromLists = Dictionary.fromLists

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				fromLists(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}
		local b = {}
		local c = fromLists(a, b)

		expect(c).never.to.equal(a)
		expect(c).never.to.equal(b)
	end)

	it("should not mutate passed in tables", function()
		local keyMutations = 0
		local valueMutations = 0

		local keys = { "foo", "bar" }
		local values = { 1, 2 }

		setmetatable(keys, {
			__newindex = function()
				keyMutations = keyMutations + 1
			end,
		})

		setmetatable(values, {
			__newindex = function()
				valueMutations = valueMutations + 1
			end,
		})

		fromLists(keys, values)

		expect(keyMutations).to.equal(0)
		expect(valueMutations).to.equal(0)
	end)

	it("should create a dictionary given 2 lists", function()
		local keys = { "foo", "bar" }
		local values = { 1, 2 }
		local dictionary = fromLists(keys, values)

		expect(dictionary.foo).to.equal(values[1])
		expect(dictionary.bar).to.equal(values[2])
	end)

	it("should throw if given lists are not the same size", function()
		expect(function()
			fromLists({ "foo" }, { 1, 2 })
		end).to.throw()
	end)

	it("should not skip None values", function()
		local keys = { None, "bar" }
		local values = { 1, None }
		local dictionary = fromLists(keys, values)

		expect(dictionary[None]).to.equal(values[1])
		expect(dictionary.bar).to.equal(None)
	end)

	it("should replace duplicate keys with later values", function()
		local keys = { "foo", "bar", "foo" }
		local values = { 1, 2, 3 }
		local dictionary = fromLists(keys, values)

		expect(dictionary.foo).to.equal(values[3])
		expect(dictionary.bar).to.equal(values[2])
	end)
end