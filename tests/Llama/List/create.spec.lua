return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local create = List.create

	it("should validate types", function()
		local _, err = pcall(function()
			create(0.5)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should create a list of values", function()
		local list = create(5, "foo")

		expect(#list).to.equal(5)
		
		for _, v in pairs(list) do
			expect(v).to.equal(list[1])
		end
	end)
end