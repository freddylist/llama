return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local Dictionary = Llama.Dictionary
	local removeIn = Dictionary.removeIn
	local equalsDeep = Dictionary.equalsDeep

	it("provides shorthand for updateIn to remove a single value", function()
		local m = { a = { b = { c = "X", d = "Y" } } }
		local result = removeIn(m, { "a", "b", "c" })
		expect(equalsDeep(result, { a = { b = { d = "Y" }} })).to.equal(true)
	end)

	it("does not create empty maps for an unset path", function()
		local result = removeIn({}, { "a", "b", "c" })
		expect(equalsDeep(result, {})).to.equal(true)
	end)

	it("removes itself when removing empty path", function()
		local m = {}
		expect(removeIn({}, {})).to.never.be.ok()
	end)
end
