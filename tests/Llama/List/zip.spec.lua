return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local zip = List.zip

	it("should return a new table", function()
		local a = {}

		expect(zip(a, {})).never.to.equal(a)
	end)
	
	it("should not mutate the given table(s)", function()
		local a = { 1, 2, 3 }
		local b = { 4, 5, 6 }
		local mutationsA = 0
		local mutationsB = 0

		setmetatable(a, {
			__newindex = function()
				mutationsA = mutationsA + 1
			end
		})

		setmetatable(b, {
			__newindex = function()
				mutationsB = mutationsB + 1
			end
		})

		zip(a, b)

		expect(mutationsA).to.equal(0)
		expect(mutationsB).to.equal(0)
	end)

	it("should zip the provided tables together", function()
		local unzipped = {
			{ 1, 2, 3 },
			{ 'a', 'b', 'c' },
			{ "foo", "bar", "baz" },
		}
		local zipped = zip(unzipped[1], unzipped[2], unzipped[3])

		for k, v in pairs(zipped) do
			for l, w in pairs(v) do
				expect(w).to.equal(unzipped[l][k])
			end
		end
	end)

	it("should only zip up to longest length", function()
		local a = {1, 2, 3}
		local b = {4, 5}
		local zipped = zip(a, b)

		expect(zipped[3]).to.equal(nil)
	end)
end