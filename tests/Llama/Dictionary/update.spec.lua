return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local update = Dictionary.update

	it("should return a new table", function()
		local a = {}

		expect(update(a, "")).never.to.equal(a)
	end)

	it("should not mutate the given table", function()
		local a = {
			foo = "foo",
			bar = "bar",
			baz = "baz"
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		update(a, "baz")

		expect(mutations).to.equal(0)
	end)

	it("should update value at specified key", function()
		local a = {
			foo = "foo",
			bar = "bar",
		}

		local b = update(a, "bar", function(v)
			return v .. "foo"
		end)

		expect(b.bar).to.equal("barfoo")
	end)

	it("should change key if provided by updater", function()
		local a = {
			foo = "foo",
			bar = "bar",
		}

		local b = update(a, "bar", function(v, k)
			return v, k .. "foo"
		end)

		expect(b.barfoo).to.equal(a.bar)
	end)

	it("should call callback with true if key exists", function()
		local a = {
			foo = "foo",
			bar = "bar",
		}

		update(a, "bar", function(v, k)
			return v, k .. "foo"
		end, function(updated)
			expect(updated).to.equal(true)
		end)
	end)

	it("should call callback with false and if key does not exist, and create entry if provided", function()
		local a = {
			foo = "foo",
			bar = "bar",
		}

		local b = update(a, "baz", nil, function(updated)
			expect(updated).to.equal(false)
			return "yeet"
		end)

		expect(b.baz).to.equal("yeet")
	end)
end