return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local List = Llama.List
	local zipAll = List.zipAll

	it("should validate types", function()
		local _, err = pcall(function()
			zipAll(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(zipAll(a, {})).never.to.equal(a)
	end)
	
	it("should not mutate passed in tables", function()
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

		zipAll(a, b)

		expect(mutationsA).to.equal(0)
		expect(mutationsB).to.equal(0)
	end)

	it("should zip the provided tables together", function()
		local unzipped = {
			{ 1, 2, 3 },
			{ 'a', 'b', 'c' },
			{ "foo", "bar", "baz" },
		}
		local zipped = zipAll(unzipped[1], unzipped[2], unzipped[3])

		for k, v in pairs(zipped) do
			for l, w in pairs(v) do
				expect(w).to.equal(unzipped[l][k])
			end
		end
	end)

	it("should zip as much as possible, replacing non existant entries with None", function()
		local a = { 1, 2, 3 }
		local b = { 4, 5 }
		local zipped = zipAll(a, b)

		expect(zipped[3][1]).to.equal(3)
		expect(zipped[3][2]).to.equal(None)
	end)
end