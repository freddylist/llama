return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local map = Dictionary.map

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
			{ 0, function() end }
		}

		for i = 1, #args do
			local _, err = pcall(function()
				map(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		local function doNothing(v)
			return v
		end

		expect(map(a, doNothing)).never.to.equal(a)
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

		local function doNothing(v)
			return v
		end

		map(a, doNothing)

		expect(mutations).to.equal(0)
	end)

	it("should call the callback for each element", function()
		local a = {
			foo = 1, 
			bar = 2, 
			baz = 3,
		}
		local copy = {}

		local function copier(v, k)
			copy[k] = v
			return v
		end

		map(a, copier)

		for k, v in pairs(a) do
			expect(copy[k]).to.equal(v)
		end

		for k, v in pairs(copy) do
			expect(v).to.equal(a[k])
		end
	end)

	it("should set the new values to the first result of the given callback", function()
		local a = {
			foo = 1, 
			bar = 2, 
			baz = 3,
		}

		local function double(v)
			return v * 2
		end

		local b = map(a, double)

		for k, v in pairs(b) do
			expect(double(a[k])).to.equal(v)
		end
	end)

	it("should set the new keys to the second result of the given callback", function()
		local a = {
			foo = 1, 
			bar = 2, 
			baz = 3,
		}

		local function barify(v, k)
			return v, k .. "bar"
		end

		local b = map(a, barify)

		for k, v in pairs(a) do
			expect(b[k .. "bar"]).to.equal(v)
			expect(b[k]).never.to.be.ok()
		end
	end)

	it("should remove values when nil is returned", function()
		local a = {
			foo = 1, 
			bar = 2, 
			baz = 3,
		}

		local function nothing()
			return nil
		end

		local b = map(a, nothing)

		expect(next(b, nil)).never.to.be.ok()
	end)

	it("should work with an empty list", function()
		local a = {}
		local b = map(a, function() end)

		expect(b).to.be.a("table")
		expect(b).never.to.equal(a)
	end)
end