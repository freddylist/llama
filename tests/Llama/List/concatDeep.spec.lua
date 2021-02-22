return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local List = Llama.List
	local concatDeep = List.concatDeep

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				concatDeep(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		expect(concatDeep(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		concatDeep(a)

		expect(mutations).to.equal(0)
	end)

	it("should remove elements equal to None", function()
		local a = {
			"foo-a"
		}

		local b = {
			None,
			"foo-b"
		}

		local c = concatDeep(a, b)

		expect(#c).to.equal(2)
		expect(c[1]).to.equal("foo-a")
		expect(c[2]).to.equal("foo-b")
	end)

	it("should accept arbitrary numbers of tables", function()
		local a = { 1 }
		local b = { 2 }
		local c = { 3 }

		local d = concatDeep(a, b, c)

		expect(#d).to.equal(3)
		expect(d[1]).to.equal(1)
		expect(d[2]).to.equal(2)
		expect(d[3]).to.equal(3)
	end)

	it("should accept zero tables", function()
		expect(concatDeep()).to.be.a("table")
	end)

	it("should accept holes in arguments", function()
		local a = { 1 }
		local b = { 2 }

		local c = concatDeep(a, nil, b)

		expect(#c).to.equal(2)
		expect(c[1]).to.equal(1)
		expect(c[2]).to.equal(2)

		local d = concatDeep(nil, a, b)

		expect(#d).to.equal(2)
		expect(d[1]).to.equal(1)
		expect(d[2]).to.equal(2)
	end)

	it("should join tables and copy subtables", function()
		local a = {
			"foo-a",
			{
				"bar-a",
				{
					"baz-a"
				}
			}
		}

		local b = {
			"foo-b",
			{
				"bar-b",
				{
					"baz-b"
				}
			}
		}

		local c = concatDeep(a, b)

		expect(c[1]).to.equal(a[1])
		expect(c[2]).never.to.equal(a[2])
		expect(c[3]).to.equal(b[1])
		expect(c[4]).never.to.equal(b[2])

		expect(c[2][1]).to.equal(a[2][1])
		expect(c[2][2]).never.to.equal(a[2][2])
		expect(c[4][1]).to.equal(b[2][1])
		expect(c[4][2]).never.to.equal(b[2][2])
		
		expect(c[2][2][1]).to.equal(a[2][2][1])
		expect(c[4][2][1]).to.equal(b[2][2][1])
	end)
end