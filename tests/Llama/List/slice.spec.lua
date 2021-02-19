return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local List = Llama.List
	local slice = List.slice

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 1.5, 2 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				slice(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return the correct range", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		slice(a)

		expect(mutations).to.equal(0)
	end)

	it("should throw when the start index is higher than the end index", function()
		local a = { 5, 8, 7, 2, 3, 7 }

		expect(function()
			slice(a, 4, 1)
		end).to.throw()
	end)

	it("should copy the table", function()
		local a = { 6, 8, 1, 3, 7, 2 }
		local b = slice(a)

		for key, value in pairs(a) do
			expect(b[key]).to.equal(value)
		end

		for key, value in pairs(b) do
			expect(value).to.equal(a[key])
		end
	end)
end