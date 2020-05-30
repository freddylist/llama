local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local TestEZ = require(lib.TestEZ)

local tests = ReplicatedStorage.tests

TestEZ.TestBootstrap:run({ tests })