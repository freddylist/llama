return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local Dictionary = Llama.Dictionary
	local updateIn = Dictionary.updateIn
	local equalsDeep = Dictionary.equalsDeep

	it("deep edit", function()
		local m = { a = { b = { c = 10 }}}
		local result = updateIn(m, {"a", "b", "c"}, function(value)
			return value * 2
		end)

		expect(equalsDeep(result, { a = { b = { c = 20 }}})).to.equal(true)
	end)

	it("deep edit throws if non-editable path", function()
		local deep = { key = { bar = { item = 10 }} }
		expect(function()
			updateIn(deep, {"key", "foo", "item"}, function()
				return "newValue"
			end)
		end).to.throw("Cannot update within non-table value in path")
	end)

	it("shallow remove", function()
		local m = { a = 123 }
		local result = updateIn(m, {"a"}, function()
			return nil
		end)
		expect(equalsDeep(result, {})).to.equal(true)
	end)

	it("deep remove", function()
		local removeKey = Dictionary.removeKey

		local m = { a = { b = { c = 10 } } }
		local result = updateIn(m, {"a", "b"}, function(map)
			return removeKey(map, "c")
		end)
		expect(equalsDeep(result, { a = { b = {} }})).to.equal(true)
	end)

	it("deep set", function()
		local set = Dictionary.set

		local m = { a = { b = { c = 10 } } }
		local result = updateIn(m, {"a", "b"}, function(map)
			return set(map, "d", 20)
		end)
		expect(equalsDeep(result, { a = { b = { c = 10, d = 20 } }})).to.equal(true)
	end)

	it("deep push", function()
		local push = Llama.List.push
		local m = { a = { b = { 1, 2, 3 }}}
		local result = updateIn(m, {"a", "b"}, function(list)
			return push(list, 4)
		end)
		expect(equalsDeep(result, { a = { b = { 1, 2, 3, 4 } }})).to.equal(true)
	end)

	it("deep map", function()
		local map = Llama.List.map
		local m = { a = { b = { 1, 2, 3 }}}
		local result = updateIn(m, {"a", "b"}, function(list)
			return map(list, function(value)
				return value * 10
			end)
		end)
		expect(equalsDeep(result, { a = { b = { 10, 20, 30 } }})).to.equal(true)
	end)

	it("creates new maps if path contains gaps", function()
		local set = Llama.Dictionary.set
		local m = { a = { b = { c = 10 }}}
		local result = updateIn(m, { "a", "x", "y" }, function(map)
			return set(map, "z", 20)
		end, {})
		expect(equalsDeep(result, { a = { b = { c = 10 }, x = { y = { z = 20 }} }})).to.equal(true)
	end)

	it("throws if path cannot be set", function()
		local m = { a = { b = { c = 10 } } }
		expect(function()
			updateIn(m, { "a", "b", "c", "d" }, function()
				return 20
			end)
		end).to.throw("Cannot update within non-table value in path")
	end)

	it("update with notSetValue when non-existing key", function()
		local m = { a = { b = { c = 10 } } }
		local result = updateIn(m, {"x"}, function(map)
			return map + 1
		end, 100)
		expect(equalsDeep(result, { x = 101, a = { b = { c = 10 } }})).to.equal(true)
	end)

	it("updates self for empty path", function()
		local set = Llama.Dictionary.set
		local m = { a = 1, b = 2, c = 3 }
		local result = updateIn(m, {}, function(map)
			return set(map, "b", 20)
		end)
		expect(equalsDeep(result, { a = 1, b = 20, c = 3 })).to.equal(true)
	end)
end
