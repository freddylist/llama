
local Dictionary = require(script.Parent.Parent:WaitForChild("Dictionary"))

local Set = {
	add			= require(script:WaitForChild("add")),
	intersect	= require(script:WaitForChild("intersect")),
	subtract	= require(script:WaitForChild("subtract")),
	union		= require(script:WaitForChild("union")),

	copy = Dictionary.copy,
	keys = Dictionary.keys,
}

return Set