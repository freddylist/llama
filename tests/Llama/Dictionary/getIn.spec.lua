return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)
	local getIn = Llama.Dictionary.getIn

	describe("GIVEN a dictionary with layers x, y, and z", function()
		local dictionary = { x = { y = { z = 123 }}}

		it("SHOULD return 123 when given {x, y, z}", function()
			local result = getIn(dictionary, {"x", "y", "z"})
			expect(result).to.equal(123)
		end)

		it("SHOULD return the given default when given {x, q, p}", function()
			local result = getIn(dictionary, {"x", "q", "p"}, "someDefaultValue")
			expect(result).to.equal("someDefaultValue")
		end)

		it("SHOULD return nil if path does not match and there is no default given", function()
			expect(getIn(dictionary, {"a", "b", "c"})).to.equal(nil)
			expect(getIn(dictionary, {"x", "b", "c"})).to.equal(nil)
			expect(getIn(dictionary, {"x", "y", "c"})).to.equal(nil)
		end)

		it("SHOULD return not found if path encounters non-data-structure", function()
			local m = { a = { b = { c = nil }}}
			local keyPath = { "a", "b", "c", "x" }
			expect(getIn(m, keyPath)).to.equal(nil)
			expect(getIn(m, keyPath, "default")).to.equal("default")
		end)
	end)

	local function itShouldThrowAsKeyPath(given)
		return function()
			it("SHOULD throw", function()
				expect(function()
					getIn({}, given)
				end).to.throw()
			end)
		end
	end
	describe("GIVEN a number as keyPath", itShouldThrowAsKeyPath(10))
	describe("GIVEN string as keyPath", itShouldThrowAsKeyPath("abc"))
	describe("GIVEN nil as keyPath", itShouldThrowAsKeyPath(nil))
end
