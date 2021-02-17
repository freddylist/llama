return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local insert = List.insert

	it("should return a new table", function()
		local list = {1, 2, 3}

		expect(insert(list, 2, 0)).never.to.equal(list)
	end)

	it("should not mutate the original list", function()
		local list = {false, "foo", 3}
		local mutations = 0

		setmetatable(list, {
			__newindex = function()
				mutations = mutations + 1
			end
		})

		insert(list, 2, true)

		expect(mutations).to.equal(0)
	end)

	it("should add values at the given index, shifting the rest of the list over", function()
		local list = {1, 2, 3}
		local value = {}
		local result = insert(list, 2, value, 4)

		expect(result[1]).to.equal(1)
		expect(result[2]).to.equal(value)
		expect(result[3]).to.equal(4)
		expect(result[4]).to.equal(2)
		expect(result[5]).to.equal(3)
		expect(next(result[2])).to.equal(nil)
	end)

	it("should throw if the given index is higher than the list length + 1", function()
		local list = {1}

		expect(function()
			insert(list, #list + 2, {})
		end).to.throw()
	end)

	it("should throw if the given index is lower than 1", function()
		local list = {1}

		expect(function()
			insert(list, 0, {})
		end).to.throw()
	end)

	it("should be able to insert a falsy value", function()
		local tableElement = {}
		local list = {tableElement, false, "value", true}
		local newValue = false

		local result = insert(list, 3, newValue)

		expect(result[1]).to.equal(tableElement)
		expect(result[2]).to.equal(false)
		expect(result[3]).to.equal(newValue)
		expect(result[4]).to.equal("value")
		expect(result[5]).to.equal(true)
	end)
end