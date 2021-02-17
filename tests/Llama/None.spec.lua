return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)
	local None = Llama.None

	it("should be a userdata", function()
		expect(None).to.be.a("userdata")
	end)

	it("should have a nice string name", function()
		local coerced = tostring(None)

		expect(coerced:find("^userdata: ")).never.to.be.ok()
		expect(coerced:find("None")).to.be.ok()
	end)
end