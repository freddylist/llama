return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)
	local equalObjects = Llama.equalObjects

	it("should return a boolean", function()
		local a = {"a", "b", "c"}
		local b = a
		local c = {"d", "e", "f"}

		expect(equalObjects(a, b)).to.be.a("boolean")
		expect(equalObjects(a, c)).to.be.a("boolean")
	end)

	it("should return true if tables have object equality", function()
		local a = {"a", "b", "c"}
		local b = a

		expect(equalObjects(a, b)).to.equal(true)
	end)

	it("should return false even if tables have value equality", function()
		local a = {"a", "b", "c"}
		local b = {"a", "b", "c"}

		expect(equalObjects(a, b)).to.equal(false)
	end)

	it("should accept arbitrary numbers of tables", function()
		local a = {"a", "b", "c"}
		local b = {"a", "b", "c"}
		local c = a
		local d = b
		local e = c
		local f = d

		expect(equalObjects(a, b, c, d, e, f)).to.equal(false)
		expect(equalObjects(a, c, e)).to.equal(true)
		expect(equalObjects(a, b, e)).to.equal(false)
	end)

	it("should accept one table", function()
		local a = {"a", "b", "c"}

		expect(equalObjects(a)).to.equal(true)
		expect(equalObjects()).to.equal(true)
	end)

	it("should accept zero tables", function()
		expect(equalObjects()).to.equal(true)
	end)
end