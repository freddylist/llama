return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local Set = Llama.Set
	local toList = Set.toList

	it("should validate types", function()
		local _, err = pcall(function()
			toList(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should not mutate passed in tables", function()
		local a = {
			foo = true,
			bar = true,
			baz = true,
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end
		})

		toList(a)

		expect(mutations).to.equal(0)
	end)

	it("should return the correct values", function()
		local a = {
			foo = true,
			bar = true,
			baz = true,
		}
		local keyCount = {
			foo = 1,
			bar = 1,
			baz = 1,
		}
		local b = toList(a)

		expect(#b).to.equal(3)

		for _, key in ipairs(b) do
			expect(keyCount[key]).to.be.ok()
			keyCount[key] = keyCount[key] - 1
		end

		for _, count in pairs(keyCount) do
			expect(count).to.equal(0)
		end
	end)

	it("should work with an empty table", function()
		local a = toList({})

		expect(next(a)).never.to.be.ok()
	end)

	it("should contain a None element if there is a None key in the set", function()
		local a = {
			[None] = true,
			bar = true
		}
		local keyCount = {
			[None] = 1,
			bar = 1
		}
		local b = toList(a)

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