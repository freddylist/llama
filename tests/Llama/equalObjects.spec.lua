return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)
	local equalObjects = Llama.equalObjects

	it("should return a boolean", function()
		local a = {1, 2, 3}
		local b = a
		local c = {4, 5, 6}

		expect(equalObjects(a, b)).to.be.a("boolean")
		expect(equalObjects(a, c)).to.be.a("boolean")
	end)

	it("should return true if tables have reference equality", function()
		local a = {1, 2, 3}
		local b = a

		expect(equalObjects(a, b)).to.equal(true)
	end)

	it("should return false even if tables have value equality", function()
		local a = {1, 2, 3}
		local b = {1, 2, 3}

		expect(equalObjects(a, b)).to.equal(false)
	end)

	it("should accept arbitrary numbers of objects", function()
		local a = {1, 2, 3}
		local b = a
		local c = b
		local d = {1, 2, 3}
		local e = d
		local f = e

		expect(equalObjects(a, b, c, d, e, f)).to.equal(false)
		expect(equalObjects(a, b, c)).to.equal(true)
	end)

	it("should accept one object", function()
		local a = {1, 2, 3}

		expect(equalObjects(a)).to.equal(true)
	end)

	it("should accept zero objects", function()
		expect(equalObjects()).to.equal(true)
	end)

	it("should accept zero tables", function()
		expect(equalObjects()).to.equal(true)
	end)

	it("should accept any type", function()
		expect(equalObjects(1, 1)).to.equal(true)
		expect(equalObjects(1, 2)).to.equal(false)
	end)
end