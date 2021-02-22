return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Set = Llama.Set
	local filter = Set.filter

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end }
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
		local a = {
			foo = true, 
			bar = true, 
			baz = true,
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		local function alwaysTrue()
			return true
		end

		filter(a, alwaysTrue)

		expect(mutations).to.equal(0)
	end)

	it("should call the callback for each element", function()
		local a = {
			foo = true, 
			bar = true, 
			baz = true,
		}
		local copy = {}

		local function copyCallback(v)
			copy[v] = true
			return true
		end

		filter(a, copyCallback)

		for k, v in pairs(a) do
			expect(copy[k]).to.equal(v)
		end

		for k, v in pairs(copy) do
			expect(v).to.equal(a[k])
		end
	end)

	it("should correctly use the filter callback", function()
		local a = {
			[1] = true,
			[2] = true,
			[3] = true,
			[4] = true,
			[5] = true,
		}

		local function evenOnly(v)
			return v % 2 == 0
		end

		local b = filter(a, evenOnly)

		expect(b[1]).never.to.be.ok()
		expect(b[2]).to.be.ok()
		expect(b[3]).never.to.be.ok()
		expect(b[4]).to.be.ok()
		expect(b[5]).never.to.be.ok()
	end)

	it("should copy the table correctly", function()
		local a = {
			foo = true, 
			bar = true, 
			baz = true,
		}

		local function keepAll()
			return true
		end

		local b = filter(a, keepAll)

		for k, v in pairs(a) do
			expect(b[k]).to.equal(v)
		end

		for k, v in pairs(b) do
			expect(v).to.equal(a[k])
		end
	end)

	it("should work with an empty table", function()
		local called = false

		local function callback()
			called = true
			return true
		end

		local a = filter({}, callback)

		expect(next(a)).never.to.be.ok()
		expect(called).to.equal(false)
	end)

	it("should remove all elements from given table when callback return always false", function()
		local a = {
			foo = true, 
			bar = true, 
			baz = true,
		}

		local function removeAll()
			return false
		end

		local b = filter(a, removeAll)

		expect(next(b)).never.to.be.ok()
	end)
end