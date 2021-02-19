return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local first = List.first

	it("should return the first element of a list", function()
		local a = { "foo", "bar" }

		expect(first(a)).to.equal("foo")
	end)
end