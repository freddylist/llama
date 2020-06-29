return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local removeValue = Dictionary.removeValue

	it("should return a new table", function()
		local a = {
			llama = "cool",
		}

		local b = removeValue(a, "cool")

		expect(b).never.to.equal(a)
		expect(b).to.be.a("table")
	end)

	it("should remove a single value", function()
		local a = {
			llama = "cool",
			cryo = "cooler",
			mutability = "coolest",
			banana = "coolest",
		}

		local b = removeValue(a, "coolest")

		expect(b.mutability).to.equal(nil)
		expect(b.banana).to.equal(nil)
	end)

	it("should remove multiple values", function()
		local a = {
			llama = "cool",
			cryo = "cooler",
			mutability = "coolest",
			bad = "something",
		}

		local b = removeValue(a, "coolest", "something")

		expect(b.mutability).to.equal(nil)
		expect(b.bad).to.equal(nil)
	end)

	it("should work even if value does not exist", function()
		local a = {
			llama = "cool",
			cryo = "coolor",
		}

		expect(function()
			removeValue(a, "mutability")
		end).never.to.throw()
	end)
end