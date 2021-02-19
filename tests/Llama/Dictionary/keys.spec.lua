return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local Dictionary = Llama.Dictionary
	local keys = Dictionary.keys

	it("should validate types", function()
		local _, err = pcall(function()
			keys(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(keys({a})).never.to.equal(a)
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

		keys(a)

		expect(mutations).to.equal(0)
	end)

	it("should return the correct keys", function()
		local a = {
			foo = 1,
			bar = 2,
		}
		local keyCount = {
			foo = 1,
			bar = 1,
		}
		local b = keys(a)

		expect(#b).to.equal(2)

		for _, key in ipairs(b) do
			expect(keyCount[key]).to.be.ok()
			keyCount[key] = keyCount[key] - 1
		end

		for _, count in pairs(keyCount) do
			expect(count).to.equal(0)
		end
	end)

	it("should work with an empty table", function()
		local a = keys({})

		expect(next(a)).never.to.be.ok()
	end)

	it("should contain a None element if there is a None key in the dictionary", function()
		local a = {
			[None] = "foo",
			bar = "bar"
		}
		local keyCount = {
			[None] = 1,
			bar = 1
		}
		local b = keys(a)

		expect(#b).to.equal(2)

		for _, key in ipairs(b) do
			expect(keyCount[key]).to.be.ok()
			keyCount[key] = keyCount[key] - 1
		end
		
		for _, count in pairs(keyCount) do
			expect(count).to.equal(0)
		end
	end)
end