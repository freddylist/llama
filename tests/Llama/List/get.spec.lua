return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local get = List.get

	it("should get the value at the specified index", function()
		local a = {
			4,
			5,
			6,
		}

		expect(get(a, 1)).to.equal(4)
		expect(get(a, 2)).to.equal(5)
		expect(get(a, 3)).to.equal(6)
		expect(get(a, 4)).to.equal(nil)
	end)
end