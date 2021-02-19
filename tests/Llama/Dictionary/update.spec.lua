return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local update = Dictionary.update

	it("should validate types", function()
		local args = {
			{ 0 },
			{ 0, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				update(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		expect(update(a, "foo")).never.to.equal(a)
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

		update(a, "foo")

		expect(mutations).to.equal(0)
	end)

	it("should update value at specified key", function()
		local a = {
			foo = 1,
			bar = 2,
		}

		local function double(v)
			return v * 2
		end

		local b = update(a, "bar", double)

		expect(b.bar).to.equal(double(a.bar))
	end)

	it("should call callback if key does not exist and create entry if provided", function()
		local a = {
			foo = 1,
			bar = 2,
		}

		local b = update(a, "baz", nil, function()
			return 3
		end)

		expect(b.baz).to.equal(3)
	end)

	it("should pass key and value to update and callback", function()
		local a = {
			foo = 1,
			bar = 2,
		}

		update(a, "bar", function(value, key)
			expect(value).to.equal(2)
			expect(key).to.equal("bar")
		end)

		update(a, "baz", nil, function(key)
			expect(key).to.equal("baz")
		end)
	end)
end