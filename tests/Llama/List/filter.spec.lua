return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local filter = List.filter

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				filter(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		expect(filter(a, function() end)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		filter(a, function() end)

		expect(mutations).to.equal(0)
	end)

	it("should call the callback for each element", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}
		local copy = {}

		local function copyCallback(value, index)
			copy[index] = value
			return true
		end

		filter(a, copyCallback)

		for key, value in pairs(a) do
			expect(copy[key]).to.equal(value)
		end

		for key, value in pairs(copy) do
			expect(value).to.equal(a[key])
		end
	end)

	it("should correctly use the filter callback", function()
		local a = { 1, 2, 3, 4, 5 }

		local function onlyEvens(value)
			return value % 2 == 0
		end

		local b = filter(a, onlyEvens)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal(2)
		expect(b[2]).to.equal(4)
	end)

	it("should copy the list correctly", function()
		local a = { 1, 2, 3 }

		local function keepAll()
			return true
		end

		local b = filter(a, keepAll)

		for key, value in pairs(a) do
			expect(b[key]).to.equal(value)
		end

		for key, value in pairs(b) do
			expect(value).to.equal(a[key])
		end
	end)

	it("should work with an empty table", function()
		local called = false

		local function callback()
			called = true
			return true
		end

		local a = filter({}, callback)

		expect(#a).to.equal(0)
		expect(called).to.equal(false)
	end)

	it("should remove all elements from a list when callback return always false", function()
		local a = { 6, 2, 8, 6, 7 }

		local function removeAll()
			return false
		end

		local b = filter(a, removeAll)

		expect(#b).to.equal(0)
	end)
end