
local SetTests = script.Parent

local LlamaTests = SetTests.Parent

local DictionaryTests = LlamaTests.Dictionary
local copyTest = require(DictionaryTests["copy.spec"])

return copyTest