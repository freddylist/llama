return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local update = List.update

	it("should return a new table", function()
		local a = {}

		expect(update(a, 1)).never.to.equal(a)
	end)

	it("should not mutate the given table", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		update(a, 3)

		expect(mutations).to.equal(0)
	end)

	it("should update value at specified index", function()
		local a = {
			"foo",
			"bar",
		}

		local b = update(a, 2, function(v)
			return v .. "foo"
		end)

		expect(b[2]).to.equal("barfoo")
	end)

	it("should call callback with true if index exists", function()
		local a = {
			"foo",
			"bar",
		}

		update(a, 2, nil, function(updated)
			expect(updated).to.equal(true)
		end)
	end)

	it("should call callback with false and if index does not exist, create entry if provided", function()
		local a = {
			"foo",
			"bar",
		}

		local b = update(a, 3, nil, function(updated)
			expect(updated).to.equal(false)
			return "yeet"
		end)

		expect(b[3]).to.equal("yeet")
	end)
end