return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local insert = List.insert

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 1.5 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				insert(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)
	
	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(insert(a, 2, 0)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		insert(a, 3, "baz")

		expect(mutations).to.equal(0)
	end)

	it("should add values at the given index, shifting the rest of the list over", function()
		local a = { 1, 2, 3 }
		local value = {}
		local result = insert(a, 2, value, 4)

		expect(result[1]).to.equal(1)
		expect(result[2]).to.equal(value)
		expect(result[3]).to.equal(4)
		expect(result[4]).to.equal(2)
		expect(result[5]).to.equal(3)
		expect(next(result[2])).never.to.be.ok()
	end)

	it("should throw if the given index is higher than the list length + 1", function()
		local a = {1}

		expect(function()
			insert(a, #a + 2, {})
		end).to.throw()
	end)

	it("should be able to insert a falsy value", function()
		local tableElement = {}
		local a = { tableElement, false, "value", true }
		local newValue = false

		local result = insert(a, 3, newValue)

		expect(result[1]).to.equal(tableElement)
		expect(result[2]).to.equal(false)
		expect(result[3]).to.equal(newValue)
		expect(result[4]).to.equal("value")
		expect(result[5]).to.equal(true)
	end)
end