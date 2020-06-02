return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local map = Dictionary.map

	it("should return a new table", function()
		local a = {}

		expect(map(a, function(v)
			return v
		end)).never.to.equal(a)
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

		map(a, function(v)
			return v
		end)

		expect(mutations).to.equal(0)
	end)

	it("should call the callback for each element", function()
		local a = {
			foo = "foo", 
			bar = "bar", 
			baz = "baz",
		}
		local copy = {}
		map(a, function(v, k)
			copy[k] = v
			return v
		end)

		for k, v in pairs(a) do
			expect(copy[k]).to.equal(v)
		end

		for k, v in pairs(copy) do
			expect(v).to.equal(a[k])
		end
	end)

	it("should set the new values to the first result of the given callback", function()
		local a = {
			foo = "foo", 
			bar = "bar", 
			baz = "baz",
		}
		local b = map(a, function(v)
			return v .. "bar"
		end)

		for k, v in pairs(b) do
			expect(a[k] .. "bar").to.equal(v)
		end
	end)

	it("should set the new keys to the second result of the given callback", function()
		local a = {
			foo = "foo", 
			bar = "bar", 
			baz = "baz",
		}
		local b = map(a, function(v, k)
			return v, k .. "bar"
		end)

		for k, v in pairs(a) do
			expect(b[k .. "bar"]).to.equal(v)
		end
	end)

	it("should remove values when nil is returned", function()
		local a = {
			foo = "foo", 
			bar = "bar", 
			baz = "baz",
		}
		local b = map(a, function()
			return nil
		end)

		expect(#b).to.equal(0)
	end)

	it("should work with an empty list", function()
		local a = {}
		local b = map(a, function() end)

		expect(b).to.be.a("table")
		expect(b).never.to.equal(a)
	end)
end