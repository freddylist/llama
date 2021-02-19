return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local last = List.last

	it("should return the last element of a list", function()
		local a = { "foo", "bar" }

		expect(last(a)).to.equal("bar")
	end)
end