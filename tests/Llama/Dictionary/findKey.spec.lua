return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local findKey = Dictionary.findKey

	it("should validate types", function()
		local args = {
			{ 0 },
			{ 0, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				findKey(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return the key that the value is matched to or nil", function()
		local a = {
			foo = "oof",
			bar = "rab",
			baz = "zab"
		}

		expect(findKey(a, "oof")).to.equal("foo")
		expect(findKey(a, "foo")).to.equal(nil)
	end)

	it("should honor the predicate", function()
		local a = {
			foo = "oof",
			bar = "oof",
			baz = "oof"
		}

		expect(findKey(a, "oof", function(key)
			return key ~= "foo" and key ~= "bar"
		end)).to.equal("baz")
	end)

	it("should return nil when the predicate is not met", function()
		local a = {
			foo = "oof",
			bar = "oof",
			baz = "oof"
		}

		expect(findKey(a, "oof", function(key)
			return key ~= "foo" and key ~= "bar" and key ~= "baz"
		end)).to.equal(nil)
	end)
end