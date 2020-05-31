return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local delete = Dictionary.delete

	it("should return a new table", function()
		local a = {
			llama = "cool",
		}

		local b = delete(a, "llama")

		expect(b).never.to.equal(a)
		expect(b).to.be.a("table")
	end)

	it("should delete a single entry", function()
		local a = {
			llama = "cool",
			cryo = "coolor",
			mutability = "coolest",
		}

		local b = delete(a, "mutability")

		expect(b.mutability).to.equal(nil)
	end)

	it("should delete multiple entries", function()
		local a = {
			llama = "cool",
			cryo = "coolor",
			mutability = "coolest",
			bad = "something",
		}

		local b = delete(a, "mutability", "bad")

		expect(b.mutability).to.equal(nil)
		expect(b.bad).to.equal(nil)
	end)

	it("should work even if entry does not exist", function()
		local a = {
			llama = "cool",
			cryo = "coolor",
		}

		expect(function()
			delete(a, "mutability")
		end).never.to.throw()
	end)
end