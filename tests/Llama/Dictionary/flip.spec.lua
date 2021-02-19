return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local flip = Dictionary.flip

	it("should validate types", function()
		local _, err = pcall(function()
			flip(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}
		local b = flip(a)

		expect(a).never.to.equal(b)
	end)

	it("should not mutate passed in tables", function()
		local a = {
			foo = "oof",
			bar = "rab",
			baz = "zab",
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end
		})

		flip(a)

		expect(mutations).to.equal(0)
	end)

	it("should flip keys and values", function()
		local a = {
			foo = "oof",
			bar = "rab",
			baz = "zab",
		}

		local b = flip(a)

		for k, v in pairs(b) do
			expect(k).to.equal(a[v])
		end
	end)

	it("should work with empty tables", function()
		expect(flip({})).to.be.a("table")
	end)
end