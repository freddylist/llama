return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local shift = List.shift

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 1.5 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				shift(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(shift(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		shift(a)

		expect(mutations).to.equal(0)
	end)

	it("should remove the first value of the list", function()
		local a = { 1, 2, 3 }
		local result = shift(a)

		expect(#result).to.equal(2)
		expect(result[1]).to.equal(2)
		expect(result[2]).to.equal(3)
	end)

	it("should remove the first values of the list, if a number is provided", function()
		local a = { 1, 2, 3 }
		local result = shift(a, 2)

		expect(#result).to.equal(1)
		expect(result[1]).to.equal(3)
	end)
end