return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages

	it("should load", function()
		require(Packages.Llama)
	end)
end