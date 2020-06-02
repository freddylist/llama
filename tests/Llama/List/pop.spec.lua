return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local pop = List.pop

	it("should return a new table", function()
		local list = {1, 2, 3}

		expect(pop(list)).never.to.equal(list)
	end)

	it("should not mutate the original list", function()
		local list = {false, "foo", 3}
		local mutations = 0

		setmetatable(list, {
			__newindex = function()
				mutations = mutations + 1
			end
		})

		pop(list)

		expect(mutations).to.equal(0)
	end)

	it("should remove the last value of the list", function()
		local list = {1, 2, 3}
		local result = pop(list)

		expect(result[1]).to.equal(1)
		expect(result[2]).to.equal(2)
		expect(result[3]).to.equal(nil)
	end)

	it("should remove the last values of the list, if a number is provided", function()
		local list = {1, 2, 3}
		local result = pop(list, 2)

		expect(result[1]).to.equal(1)
		expect(result[2]).to.equal(nil)
		expect(result[3]).to.equal(nil)
	end)
end