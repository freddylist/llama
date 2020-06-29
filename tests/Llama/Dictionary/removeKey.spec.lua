return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local removeKey = Dictionary.removeKey

	it("should return a new table", function()
		local a = {
			llama = "cool",
		}

		local b = removeKey(a, "llama")

		expect(b).never.to.equal(a)
		expect(b).to.be.a("table")
	end)

	it("should remove a single entry", function()
		local a = {
			llama = "cool",
			cryo = "coolor",
			mutability = "coolest",
		}

		local b = removeKey(a, "mutability")

		expect(b.mutability).to.equal(nil)
	end)

	it("should remove multiple entries", function()
		local a = {
			llama = "cool",
			cryo = "coolor",
			mutability = "coolest",
			bad = "something",
		}

		local b = removeKey(a, "mutability", "bad")

		expect(b.mutability).to.equal(nil)
		expect(b.bad).to.equal(nil)
	end)

	it("should work even if entry does not exist", function()
		local a = {
			llama = "cool",
			cryo = "coolor",
		}

		expect(function()
			removeKey(a, "mutability")
		end).never.to.throw()
	end)
end