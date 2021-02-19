return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local removeValues = Dictionary.removeValues

	it("should validate types", function()
		local _, err = pcall(function()
			removeValues(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {
			llama = "cool",
		}

		local b = removeValues(a, "cool")

		expect(b).never.to.equal(a)
		expect(b).to.be.a("table")
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

		removeValues(a, "foo")

		expect(mutations).to.equal(0)
	end)

	it("should remove multiple values", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}

		local b = removeValues(a, 2, 3)

		expect(b.bar).never.to.be.ok()
		expect(b.baz).never.to.be.ok()
	end)

	it("should work even if value does not exist", function()
		local a = {
			foo = 1,
			bar = 2,
		}

		expect(function()
			removeValues(a, "baz")
		end).never.to.throw()
	end)
end