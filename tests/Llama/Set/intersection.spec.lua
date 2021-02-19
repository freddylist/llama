return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Set = Llama.Set
	local intersection = Set.intersection

	it("should validate types", function()
		local _, err = pcall(function()
			intersection(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(intersection(a)).never.to.equal(a)
	end)
	
	it("should not mutate passed in tables(s)", function()
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

		intersection(a, b)

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

		local d = intersection(a, b, c)
		
		for k, _ in pairs(d) do
			expect(k).to.equal("foo")
		end
	end)
end