return function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Packages = ReplicatedStorage.Packages
	local Llama = require(Packages.Llama)

	local None = Llama.None

	local List = Llama.List
	local concat = List.concat

	it("should validate types", function()
		local args = {
			{ 0 },
			{ {}, 0 },
		}

		for i = 1, #args do
			local _, err = pcall(function()
				concat(unpack(args[i]))
			end)

			expect(string.find(err, "expected, got")).to.be.ok()
		end
	end)

	it("should return a new table", function()
		local a = {}

		expect(concat(a)).never.to.equal(a)
	end)

	it("should not mutate passed in tables", function()
		local a = { "foo", "bar" }
		local mutations = 0

		setmetatable(a, {
			__newindex = function()
				mutations = mutations + 1
			end,
		})

		concat(a)

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

		local c = concat(a, b)

		expect(c[1]).to.equal("foo-a")
		expect(c[2]).to.equal("foo-b")
		expect(c[3]).never.to.be.ok()
	end)

	it("should accept arbitrary numbers of tables", function()
		local a = { 1 }
		local b = { 2 }
		local c = { 3 }

		local d = concat(a, b, c)

		expect(#d).to.equal(3)
		expect(d[1]).to.equal(1)
		expect(d[2]).to.equal(2)
		expect(d[3]).to.equal(3)
	end)

	it("should accept zero tables", function()
		expect(concat()).to.be.a("table")
	end)

	it("should accept holes in arguments", function()
		local a = { 1 }
		local b = { 2 }

		local c = concat(a, nil, b)

		expect(#c).to.equal(2)
		expect(c[1]).to.equal(1)
		expect(c[2]).to.equal(2)

		local d = concat(nil, a, b)

		expect(#d).to.equal(2)
		expect(d[1]).to.equal(1)
		expect(d[2]).to.equal(2)
	end)
end