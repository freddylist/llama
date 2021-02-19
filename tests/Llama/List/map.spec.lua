return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local map = List.map

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				map(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(map(a, function() end)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		map(a, function() end)

		expect(mutations).to.equal(0)
	end)

	it("should call the callback for each element", function()
		local a = { 5, 6, 7 }
		local copy = {}

		map(a, function(value, index)
			copy[index] = value
			return value
		end)

		for key, value in pairs(a) do
			expect(copy[key]).to.equal(value)
		end

		for key, value in pairs(copy) do
			expect(value).to.equal(a[key])
		end
	end)

	it("should set the new values to the result of the given callback", function()
		local a = { 5, 6, 7 }
		local b = map(a, function(value)
			return value * 2
		end)

		expect(#b).to.equal(#a)
		for i = 1, #a do
			expect(b[i]).to.equal(a[i] * 2)
		end
	end)

	it("should remove values when nil is returned", function()
		local a = { 5, 6, 7 }
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