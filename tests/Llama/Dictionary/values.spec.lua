return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local Dictionary = Llama.Dictionary
	local values = Dictionary.values

	it("should validate types", function()
		local _, err = pcall(function()
			values(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(values({a})).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		values(a)

		expect(mutations).to.equal(0)
	end)

	it("should return the correct values", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}
		local valueCount = {
			[1] = 1,
			[2] = 1,
			[3] = 1,
		}
		local b = values(a)

		expect(#b).to.equal(3)

		for _, value in ipairs(b) do
			expect(valueCount[value]).to.be.ok()
			valueCount[value] = valueCount[value] - 1
		end

		for _, count in pairs(valueCount) do
			expect(count).to.equal(0)
		end
	end)

	it("should return duplicates if two values are the same", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 1,
		}
		local valueCount = {
			[1] = 2,
			[2] = 1,
		}
		local b = values(a)

		expect(#b).to.equal(3)

		for _, value in ipairs(b) do
			expect(valueCount[value]).to.be.ok()
			valueCount[value] = valueCount[value] - 1
		end

		for _, count in pairs(valueCount) do
			expect(count).to.equal(0)
		end
	end)

	it("should work with an empty table", function()
		local a = values({})

		expect(next(a)).never.to.be.ok()
	end)

	it("should contain a None element if there is a None value in the dictionary", function()
		local a = {
			foo = None,
			bar = 2,
		}
		local valueCount = {
			[None] = 1,
			[2] = 1,
		}
		local b = values(a)

		expect(#b).to.equal(2)

		for _, value in ipairs(b) do
			expect(valueCount[value]).to.be.ok()
			valueCount[value] = valueCount[value] - 1
		end
		
		for _, count in pairs(valueCount) do
			expect(count).to.equal(0)
		end
	end)
end