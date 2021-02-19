return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local List = Llama.List
	local copyDeep = List.copyDeep

	it("should validate types", function()
		local _, err = pcall(function()
			copyDeep(0)
		end)

		expect(string.find(err, "expected, got")).to.be.ok()
	end)

	it("should return a new table", function()
		local a = {}

		expect(copyDeep(a)).never.to.equal(a)
	end)

	it("should not remove values set to None", function()
		local a = {
			"foo",
			None,
		}

		local b = copyDeep(a)

		expect(b[2]).to.equal(None)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		copyDeep(a)

		expect(mutations).to.equal(0)
	end)

	it("should accept one (or more) tables", function()
		expect(function()
			copyDeep({})
		end).never.to.throw()
		expect(function()
			copyDeep()
		end).to.throw()
	end)

	it("should copy the table", function()
		local a = {
			"foo",
			"bar",
			"baz",
		}

		local b = copyDeep(a)

		for k, v in pairs(a) do
			expect(v).to.equal(b[k])
		end

		for k, v in pairs(b) do
			expect(v).to.equal(a[k])
		end
	end)

	it("should copy subtables", function()
		local a = {
			"foo",
			"bar",
			{
				"baz",
			},
		}

		local b = copyDeep(a)

		expect(a[3]).never.to.equal(b[3])
		
		for k, v in pairs(a[3]) do
			expect(v).to.equal(b[3][k])
		end

		for k, v in pairs(b[3]) do
			expect(v).to.equal(a[3][k])
		end
	end)
end