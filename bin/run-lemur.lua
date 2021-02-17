package.path = package.path .. ";?/init.lua"

-- If this fails, make sure you've cloned all Git submodules of this repo!
local lemur = require("modules.lemur")

local habitat = lemur.Habitat.new()
local root = habitat.game:GetService("ReplicatedStorage")

local Packages = lemur.Instance.new("Folder")
Packages.Name = "Packages"
Packages.Parent = root

local Llama = habitat:loadFromFs("src")
Llama.Name = "Llama"
Llama.Parent = Packages

local tests = habitat:loadFromFs("tests")
tests.Name = "tests"
tests.Parent = root

local TestEZ = habitat:loadFromFs("modules/testez/src")
TestEZ.Name = "TestEZ"
TestEZ.Parent = Packages

local runTests = habitat:loadFromFs("bin/run-tests.server.lua")

-- When Lemur implements a proper scheduling interface, we'll use that instead.
habitat:require(runTests)
