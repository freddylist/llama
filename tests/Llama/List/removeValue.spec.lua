return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local removeValue = List.removeValue

	it("should return a new table", function()
		local a = {
			"cool",
		}

		local b = removeValue(a, "cool")

		expect(b).never.to.equal(a)
		expect(b).to.be.a("table")
	end)

	it("should remove a single value", function()
		local a = {
			"cool",
			"cooler",
			"coolest",
			"coolest",
		}

		local b = removeValue(a, "coolest")

		expect(#b).to.equal(2)
		expect(b[1]).to.equal("cool")
		expect(b[2]).to.equal("cooler")
	end)

	it("should remove multiple values", function()
		local a = {
			"cool",
			"cooler",
			"coolest",
			"something",
		}

		local b = removeValue(a, "coolest", "something")

		expect(#b).to.equal(2)
		expect(b[1]).to.equal("cool")
		expect(b[2]).to.equal("cooler")
	end)

	it("should work even if value does not exist", function()
		local a = {
			"cool",
			"coolor",
		}

		expect(function()
			removeValue(a, "mutability")
		end).never.to.throw()
	end)
end