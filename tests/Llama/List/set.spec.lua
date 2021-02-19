return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local set = List.set

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 1.5 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				set(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(set(a, 2, 0)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		set(a, 3, "bar")

		expect(mutations).to.equal(0)
	end)

	it("should replace the value at the given index", function()
		local a = { 1, 2, 3 }
		local value = {}
		local result = set(a, 2, value)

		expect(result[1]).to.equal(1)
		expect(result[2]).to.equal(value)
		expect(result[3]).to.equal(3)
		expect(next(result[2])).never.to.be.ok()
	end)

	it("should throw if the given index is higher than the list length + 1", function()
		local a = { 1 }

		expect(function()
			set(a, #a + 2, {})
		end).to.throw()
	end)

	it("should throw if the given index is lower than 1", function()
		local a = { 1 }

		expect(function()
			set(a, 0, {})
		end).to.throw()
	end)

	it("should be able to replace to a falsy value", function()
		local tableElement = {}
		local a = {tableElement, false, "value", true}
		local newValue = false

		local result = set(a, 3, newValue)

		expect(result[1]).to.equal(tableElement)
		expect(result[2]).to.equal(false)
		expect(result[3]).to.equal(newValue)
		expect(result[4]).to.equal(true)
	end)
end