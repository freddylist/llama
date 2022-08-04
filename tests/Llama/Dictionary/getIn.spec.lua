return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local getIn = Llama.Dictionary.getIn

	describe("given a dictionary with layers x, y, and z", function()
		local dictionary = { x = { y = { z = 123 }}}

		it("should return 123 when given {x, y, z}", function()
			local result = getIn(dictionary, {"x", "y", "z"})
			expect(result).to.equal(123)
		end)

		it("should return the given default when given {x, q, p}", function()
			local result = getIn(dictionary, {"x", "q", "p"}, "someDefaultValue")
			expect(result).to.equal("someDefaultValue")
		end)

		it("should return nil if path does not match and there is no default given", function()
			expect(getIn(dictionary, {"a", "b", "c"})).to.equal(nil)
			expect(getIn(dictionary, {"x", "b", "c"})).to.equal(nil)
			expect(getIn(dictionary, {"x", "y", "c"})).to.equal(nil)
		end)

		it("should return not found if path encounters non-data-structure", function()
			local m = { a = { b = { c = nil }}}
			local keyPath = { "a", "b", "c", "x" }
			expect(getIn(m, keyPath)).to.equal(nil)
			expect(getIn(m, keyPath, "default")).to.equal("default")
		end)
	end)

	local function itShouldThrowAsKeyPath(given)
		return function()
			it("should throw", function()
				expect(function()
					getIn({}, given)
				end).to.throw()
			end)
		end
	end
	describe("given a number as keyPath", itShouldThrowAsKeyPath(10))
	describe("given string as keyPath", itShouldThrowAsKeyPath("abc"))
	describe("given nil as keyPath", itShouldThrowAsKeyPath(nil))
end
