return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local splice = List.splice

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 1.5, 6.9 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				splice(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = { 1, 2, 3 }

		expect(splice(a, 1, 1, 1)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		splice(a)

		expect(mutations).to.equal(0)
	end)

	it("should throw when the start index is higher than the end index", function()
		local a = { 5, 8, 7, 2, 3, 7 }

		expect(function()
			splice(a, 4, 1)
		end).to.throw()
	end)

	it("should replace and insert values", function()
		local a = { 1, 2, 3, 9, 8, 7, 8 }
		local b = splice(a, 4, 5, 4, 5, 6)

		for k, v in pairs(b) do
			expect(k).to.equal(v)
		end
	end)

	it("should work with an empty table", function()
		local a = splice({})

		expect(a).to.be.a("table")
		expect(#a).to.equal(0)
	end)
end