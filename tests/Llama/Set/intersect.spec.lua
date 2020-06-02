return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Set = Llama.Set
	local intersect = Set.intersect

	it("should return a new table", function()
		local a = {}

		expect(intersect(a)).never.to.equal(a)
	end)
	
	it("should not mutate the given table(s)", function()
		local a = {
			foo = true,
			bar = true,
			baz = true,
		}
		local b = {
			foobar = true,
			barbaz = true,
			bazfoo = true,
		}
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

		intersect(a, b)

		expect(mutationsA).to.equal(0)
		expect(mutationsB).to.equal(0)
	end)

	it("should return the intersections between provided sets", function()
		local a = {
			foo = true,
			oof = true,
			ofo = true,
		}
		local b = {
			foo = true,
			bar = true,
			baz = true,
		}
		local c = {
			foo = true,
			barfoo = true,
			foobaz = true,
		}

		local intersection = intersect(a, b, c)
		
		for k, _ in pairs(intersection) do
			expect(k).to.equal("foo")
		end
	end)
end