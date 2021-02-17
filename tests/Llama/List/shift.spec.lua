return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local shift = List.shift

	it("should return a new table", function()
		local list = {1, 2, 3}

		expect(shift(list)).never.to.equal(list)
	end)

	it("should not mutate the original list", function()
		local list = {false, "foo", 3}
		local mutations = 0

		setmetatable(list, {
			__newindex = function()
				mutations = mutations + 1
			end
		})

		shift(list)

		expect(mutations).to.equal(0)
	end)

	it("should remove the first value of the list", function()
		local list = {1, 2, 3}
		local result = shift(list)

		expect(result[1]).to.equal(2)
		expect(result[2]).to.equal(3)
		expect(result[3]).to.equal(nil)
	end)

	it("should remove the first values of the list, if a number is provided", function()
		local list = {1, 2, 3}
		local result = shift(list, 2)

		expect(result[1]).to.equal(3)
		expect(result[2]).to.equal(nil)
		expect(result[3]).to.equal(nil)
	end)
end