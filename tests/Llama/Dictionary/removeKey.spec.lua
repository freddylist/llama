return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local removeKey = Dictionary.removeKey

	it("should validate types", function()
		local _, err = pcall(function()
			removeKey(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(removeKey(a, "foo")).never.to.equal(a)
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

		removeKey(a, "foo")

		expect(mutations).to.equal(0)
	end)

	it("should remove a single entry", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}

		local b = removeKey(a, "baz")

		expect(b.baz).never.to.be.ok()
	end)

	it("should remove multiple entries", function()
		local a = {
			foo = 1,
			bar = 2,
			baz = 3,
		}

		local b = removeKey(a, "bar", "baz")

		expect(b.bar).never.to.be.ok()
		expect(b.baz).never.to.be.ok()
	end)

	it("should work even if entry does not exist", function()
		local a = {
			foo = 1,
			bar = 2,
		}

		expect(function()
			removeKey(a, "baz")
		end).never.to.throw()
	end)
end