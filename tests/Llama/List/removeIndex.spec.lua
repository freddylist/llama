return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local None = Llama.None

	local List = Llama.List
	local removeIndex = List.removeIndex

	it("should remove the element at the given index", function()
		local a = {
			"first",
			"second",
			"third"
		}

		local b = removeIndex(a, 2)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal("first")
		expect(b[2]).to.equal("third")
	end)

	it("should not remove any element if index is out of bound", function()
		local a = {
			"first",
			"second",
			"third"
		}
		local b = removeIndex(a, 4)

		expect(#b).to.equal(#a)
		for i = 1, #a do
			expect(b[i]).to.equal(a[i])
		end

		local c = removeIndex(a, -2)

		expect(#c).to.equal(#a)
		for i = 1, #a do
			expect(c[i]).to.equal(a[i])
		end
	end)

	it("should work with a None element", function()
		local a = {
			"first",
			None,
			"third"
		}

		local b = removeIndex(a, 1)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal(None)
		expect(b[2]).to.equal("third")
	end)
end