
local Dictionary = require(script.Parent.Parent.Dictionary)

local Set = {
	add			= require(script.add),
	intersect	= require(script.intersect),
	subtract	= require(script.subtract),
	union		= require(script.union),

	copy = Dictionary.copy,
	keys = Dictionary.keys,
}

return Set