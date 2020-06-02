return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local List = Llama.List
	local slice = List.slice

	it("should return a new table", function()
		local list = {1, 2, 3}

		expect(slice(list, 1, 1, 1)).never.to.equal(list)
	end)

	it("should throw when the start index is higher than the end index", function()
		local a = {5, 8, 7, 2, 3, 7}

		expect(function()
			slice(a, 4, 1)
		end).to.throw()
	end)

	it("should replace and insert values", function()
		local a = {1, 2, 3, 9, 8, 7, 8}
		local b = slice(a, 4, 5, 4, 5, 6)

		for k, v in pairs(b) do
			expect(k).to.equal(v)
		end
	end)

	it("should work with an empty table", function()
		local a = slice({}, 1, 5)

		expect(a).to.be.a("table")
		expect(#a).to.equal(0)
	end)

	it("should work when the start index is smaller than one", function()
		local a = {1, 2, 3, 4}
		local b = slice(a, -2, 2)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal(1)
		expect(b[2]).to.equal(2)
	end)

	it("should work when the end index is larger that the list length", function()
		local a = {1, 2, 3, 4}
		local b = slice(a, 3, 18)

		expect(#b).to.equal(2)
		expect(b[1]).to.equal(3)
		expect(b[2]).to.equal(4)
	end)
end