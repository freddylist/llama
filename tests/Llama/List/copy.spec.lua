return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local lib = ReplicatedStorage.lib
	local Llama = require(lib.Llama)

	local None = Llama.None

	local List = Llama.List
	local copy = List.copy

	it("should return a new table", function()
		local a = {}

		expect(copy(a)).never.to.equal(a)
	end)

	it("should not remove values set to None", function()
		local a = {
			"foo",
			None,
		}

		local b = copy(a)

		expect(b[2]).to.equal(None)
	end)

	it("should not mutate passed in tables", function()
		local mutationsA = 0

		local a = {
			"foo",
			"bar",
		}

		setmetatable(a, {
			__newindex = function()
				mutationsA = mutationsA + 1
			end,
		})

		copy(a)

		expect(mutationsA).to.equal(0)
	end)

	it("should accept one (or more) tables", function()
		expect(function()
			copy({})
		end).never.to.throw()

		expect(function()
			copy()
		end).to.throw()
	end)

	it("should copy the table", function()
		local a = {
			"yea",
			"jimmy",
			{
				"no",
			},
		}

		local b = copy(a)

		for k, v in pairs(a) do
			expect(v).to.equal(b[k])
		end

		for k, v in pairs(b) do
			expect(v).to.equal(a[k])
		end
	end)
end