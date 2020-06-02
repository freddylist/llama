return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local None = Llama.None

	local Set = Llama.Set
	local toList = Set.toList

	it("should not mutate the given table", function()
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
			expect(keyCount[key]).never.to.equal(nil)
			keyCount[key] = keyCount[key] - 1
		end

		for _, count in pairs(keyCount) do
			expect(count).to.equal(0)
		end
	end)

	it("should work with an empty table", function()
		local a = toList({})

		expect(next(a)).to.equal(nil)
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
			expect(keyCount[key]).never.to.equal(nil)
			keyCount[key] = keyCount[key] - 1
		end
		
		for _, count in pairs(keyCount) do
			expect(count).to.equal(0)
		end
	end)
end