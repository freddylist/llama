return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib

	it("should load", function()
		require(lib.Llama)
	end)
end