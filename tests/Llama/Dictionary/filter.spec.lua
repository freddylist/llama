return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local filter = Dictionary.filter

	it("should not mutate the given table", function()
		local a = {
			foo = "FooValue",
			bar = "BarValue",
		}
		local aCopy = {
			foo = "FooValue",
			bar = "BarValue",
		}

		local function filterer(v)
			return string.find(v, "Foo")
		end

		filter(a, filterer)

		for k, v in pairs(a) do
			expect(aCopy[k]).to.equal(v)
		end

		for k, v in pairs(aCopy) do
			expect(a[k]).to.equal(v)
		end
	end)

	it("should call the callback for each element", function()
		local a = {
			foo = "foo1",
			bar = "foo2",
			baz = "foo3"
		}
		local copy = {}

		local function copyCallback(v, index)
			copy[index] = v
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
			one = 1, 
			two = 2, 
			three = 3, 
			four = 4, 
			five = 5,
		}

		local function evenOnly(v)
			return v % 2 == 0
		end

		local b = filter(a, evenOnly)

		expect(b.one).to.equal(nil)
		expect(b.two).to.equal(2)
		expect(b.three).to.equal(nil)
		expect(b.four).to.equal(4)
		expect(b.five).to.equal(nil)
	end)

	it("should copy the table correctly", function()
		local a = {
			uno = 1, 
			dos = 2, 
			tres = 3
		}

		local function keepAll()
			return true
		end

		local b = filter(a, keepAll)

		expect(b).never.to.equal(a)

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

		expect(next(a)).to.equal(nil)
		expect(called).to.equal(false)
	end)

	it("should remove all elements from given table when callback return always false", function()
		local a = {
			six = 6, 
			two = 2, 
			eight = 8, 
			sixAgain = 6, 
			seven = 7,
		}

		local function removeAll()
			return false
		end

		local b = filter(a, removeAll)

		expect(next(b)).to.equal(nil)
	end)
end