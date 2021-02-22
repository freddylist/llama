# Usage

## Basic usage

To use Llama, simply require it as a module from where you installed it! It is also recommended that you set `Llama.Dictionary`, `Llama.List`, and `Llama.Set` to their own variables; otherwise, you'll be typing a lot!

```lua
-- Other modules...
local Llama = require(LlamaPath)

local Dictionary = Llama.Dictionary
local List = Llama.List
local Set = Llama.Set
```

## Usage with [Roact](https://github.com/Roblox/roact/) and [Rodux](https://github.com/Roblox/rodux)

Rodux requires your state to be immutable, so Llama is a great choice for manipulating it!

```lua
local function reducer(state, action)
	if action.type == "Add" then
		return Dictionary.merge(state, {
			counter = counter + 1
		})
	elseif action.type == "Subtract" then
		return Dictionary.merge(state, {
			counter = counter - 1
		})
	end
end
```