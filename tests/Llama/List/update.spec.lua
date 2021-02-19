return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local update = List.update

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 1.5 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				update(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		expect(update(a, 1)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		update(a, 1, function() end)

		expect(mutations).to.equal(0)
	end)

	it("should update value at specified index", function()
		local a = { "foo", "bar" }

		local b = update(a, 2, function(v)
			return v .. "foo"
		end)

		expect(b[2]).to.equal("barfoo")
	end)

	it("should call callback if index does not exist and create entry if provided", function()
		local a = {
			"foo",
			"bar",
		}

		local b = update(a, 3, nil, function()
			return "baz"
		end)

		expect(b[3]).to.equal("baz")
	end)
end