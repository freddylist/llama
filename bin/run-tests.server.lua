local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage.Packages
local TestEZ = require(Packages.TestEZ)

local tests = ReplicatedStorage.tests

TestEZ.TestBootstrap:run({ tests })