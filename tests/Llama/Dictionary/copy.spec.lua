return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local Dictionary = Llama.Dictionary
	local copy = Dictionary.copy

	it("should validate types", function()
		local _, err = pcall(function()
			copy(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(copy(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local mutations = 0

		local a = {
			foo = 1,
			bar = 2,
		}

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		copy(a)

		expect(mutations).to.equal(0)
	end)

	it("should not remove values set to None", function()
		local a = {
			foo = 1,
			bar = None,
		}

		local b = copy(a)

		expect(b.bar).to.equal(None)
	end)

	it("should accept 1 (or more) table(s)", function()
		expect(function()
			copy({})
		end).never.to.throw()

		expect(function()
			copy()
		end).to.throw()
	end)

	it("should copy the table", function()
		local a = {
			foo = 1,
			bar = 2,
			foobar = {
				baz = 3,
			},
		}

		local b = copy(a)

		for k, v in pairs(a) do
			expect(v).to.equal(b[k])
		end

		for k, v in pairs(b) do
			expect(v).to.equal(a[k])
		end
	end)
end