# API Reference

## Constants

### `None`

As Lua dictionaries cannot distinguish between a value not being present and a value of `nil`, `Llama.None` exists to represent values that should be interpreted as `nil`. This is especially useful when removing values with [`Dictionary.merge`](api-reference.md#merge).

---

## Dictionary

Dictionaries are tables with key-value pairs.

### Constructors

#### `fromLists`

```
Llama.Dictionary.fromLists(keys, values) -> dictionary
```

Returns a new dictionary constructed from `keys` and `values`. The lists are expected to be the same size.

*Example:*

```lua
local keys = { "foo", "bar", "baz" }
local values = { 1, 2, 3 }

Llama.Dictionary.fromLists(keys, values)
```

*Results:*

```lua
{
	foo = 1,
	bar = 2,
	baz = 3,
}
```

---

### Copying

#### `copy`

```
Llama.Dictionary.copy(dictionary) -> dictionary
```

Returns a shallow copy of `dictionary`.

---

#### `copyDeep`

```
Llama.Dictionary.copyDeep(dictionary) -> dictionary
```

Returns a deep copy of `dictionary`.

!!! warning
	Deep copying is more expensive than shallow copying and forces you to resort to the more expensive `equalsDeep` for value equality checking. Only use it when absolutely necessary.

---

### Comparing

#### `equals`

```
Llama.Dictionary.equals(...dictionaries) -> result
```

Returns whether all `dictionaries` have shallow value equality.

---

#### `equalsDeep`

```
Llama.Dictionary.equalsDeep(...dictionaries) -> result
```

Returns whether all `dictionaries` have deep value equality.

!!! warning
	Deep comparison is more expensive than shallow comparison. Only use it when absolutely necessary.

---

### Persistent changes

#### `merge`

```
Llama.Dictionary.merge(...dictionaries) -> dictionary
```

Returns a new dictionary with all of the entries of `dictionaries` merged together. Later entries replace older ones, and [`Llama.None`](api-reference.md#none) can be used to remove values.

|Aliases    |
|:---------:|
|`join`     |

*Example:*
```lua
local a = {
	key = "value",
	foo = "bar",
	removeMe = 0,
}

local b = {
	removeMe = Llama.None,
	addMe = 1,
}

Llama.Dictionary.merge(a, b)
```
*Results:*
```lua
{
	key = "value",
	foo = "bar",
	addMe = 1,
}
```

---

#### `mergeDeep`
```
Llama.Dictionary.mergeDeep(...dictionaries) -> dictionary
```
Returns a new dictionary with all of the entries of `dictionaries` deeply merged together. Later entries replace older ones, and [`Llama.None`](api-reference.md#none) can be used to remove values.

|Aliases    |
|:---------:|
|`joinDeep` |

*Example:*
```lua
local a = {
	key = "value",
	foo = "bar",
	dictionary = {
		foo = "foo",
		bar = "bar",
	},
	removeMe = 0,
}

local b = {
	removeMe = Llama.None,
	addMe = 1,
	dictionary = {
		baz = "baz",
	},
}

Llama.Dictionary.mergeDeep(a, b)
```
*Results:*
```lua
{
	key = "value",
	foo = "bar",
	addMe = 1,
	dictionary = {
		foo = "foo",
		bar = "bar",
		baz = "baz",
	},
}
```

!!! warning
	Deep merging is more expensive than shallow merging and forces you to resort to the more expensive `equalsDeep` for value equality checking. Only use it when absolutely necessary.

---

#### `removeKey`

```
Llama.Dictionary.removeKey(dictionary, key) -> dictionary
```

Returns a new dictionary with the entry at `key` is removed from `dictionary`.

---

#### `removeKeys`

```
Llama.Dictionary.removeKeys(dictionary, ...keys) -> dictionary
```

Returns new dictionary with entries at `keys` are removed from `dictionary`.

---

#### `removeValue`

```
Llama.Dictionary.removeValue(dictionary, value) -> dictionary
```

Returns a new dictionary where any entry with `value` are removed from `dictionary`.

---

#### `removeValues`

```
Llama.Dictionary.removeValues(dictionary, ...values) -> dictionary
```

Returns a new dictionary where any entry with any `values` are removed from `dictionary`.

---

#### `set`

```
Llama.Dictionary.set(dictionary, key, value) -> dictionary
```

Returns a new dictionary with the entry at `key` in `dictionary` is set to `value`.

---

#### `update`

```
Llama.Dictionary.update(dictionary, key[, updater[, callback]]) -> dictionary
```

Returns a new dictionary with the entry at `key` is updated by `updater`. If the entry does not exist, `callback` is invoked and the entry is created from its return value.

`updater` and `callback` are expected to have the following signatures:

```
updater(value, key) -> value
callback(key) -> value
```

*Example:*

```lua
local dictionary = {
	foo = "foo",
	bar = "bar",
}

local function fooify(value)
	return "foo" .. value
end

Llama.Dictionary.update(dictionary, "bar", fooify)
Llama.Dictionary.update(dictionary, "baz", fooify, function()
	return "baz"
end)
```

*Results:*

```lua
{
	foo = "foo",
	bar = "foobar",
}

{
	foo = "foo",
	bar = "bar",
	baz = "baz",
}
```

---

### Sequence algorithms

#### `filter`

```
Llama.Dictionary.filter(dictionary, filterer) -> dictionary
```

Returns a new dictionary with only the entries of `dictionary` for which `filterer` returns a truthy.

`filterer` is expected to have the following signature:

```
filterer(value, key) -> result
```

*Example:*

```lua
local dictionary = {
	foo1 = "foo",
	foo2 = "foo",
	bar1 = "bar",
}

local function onlyFoo(value)
	return value == "foo"
end

Llama.Dictionary.filter(dictionary, onlyFoo)
```

*Results:*

```lua
{
	foo1 = "foo",
	foo2 = "foo",
}
```

---

#### `flip`

```
Llama.Dictionary.flip(dictionary) -> dictionary
```

Returns a new dictionary with the keys and values of `dictionary` swapped.

*Example:*

```lua
local dictionary = {
	foo = "oof",
	bar = "rab",
	baz = "zab",
}

Llama.Dictionary.flip(dictionary)
```

*Results:*

```lua
{
	oof = "foo",
	rab = "bar",
	zab = "baz",
}
```

---

#### `map`

```
Llama.Dictionary.map(dictionary, mapper) -> dictionary
```

Returns a new dictionary with the values (and keys) of `dictionary` mapped over using `mapper`.

`mapper` is expected to have the following signature:

```
mapper(value, key) -> value[, key]
```

*Example:*

```lua
local dictionary = {
	foo = "foo",
	bar = "bar",
	baz = "baz",
}

local function fooify(value)
	return "foo" .. value
end

Llama.Dictionary.map(dictionary, fooify)
```

*Results:*

```lua
{
	foo = "foofoo",
	bar = "foobar",
	baz = "foobaz",
}
```

---

### Reading values

#### `has`

```
Llama.Dictionary.has(dictionary, key) -> result
```

Returns whether `dictionary` has a value at the `key`.

---

#### `includes`

```
Llama.Dictionary.includes(dictionary, value) -> result
```

Returns whether `dictionary` includes a `value`.

---

### Conversion

#### `keys`

```
Llama.Dictionary.keys(dictionary) -> list
```

Returns a list of `dictionary`'s keys.

---

#### `values`

```
Llama.Dictionary.values(dictionary) -> list
```

Returns a list of `dictionary`'s values.

---

### Reducing

#### `count`

```
Llama.Dictionary.count(dictionary[, predicate]) -> result
```

Returns the number of entries in `dictionary` for which `predicate` returns a truthy. If `predicate` is not provided, `count` simply counts all of the entries in `dictionary` (useful since `#dictionary` does not give the number of dictionary entries, only the number of list entries).

`predicate` is expected to have the following signature:

```
predicate(value, key) -> result
```

*Example:*

```lua
local dictionary = {
	foo1 = "foo",
	foo2 = "foo",
	bar1 = "bar",
	bar2 = "bar",
}

local function onlyFoo(value)
	return value == "foo"
end

Llama.Dictionary.count(dictionary, onlyFoo)
```

*Results:*

```lua
2
```

---

#### `every`

```
Llama.Dictionary.every(dictionary, predicate) -> result
```

Returns whether `predicate` returns a truthy for ***all*** of `dictionary`'s entries.

`predicate` is expected to have the following signature:

```
predicate(value, key) -> result
```

*Example:*

```lua
local a = {
	foo1 = "foo",
	foo2 = "foo",
}

local b = {
	foo = "foo",
	bar = "bar",
	baz = "baz",
}

local function onlyFoo(value)
	return value == "foo"
end

Llama.Dictionary.every(a, onlyFoo)
Llama.Dictionary.every(b, onlyFoo)
```

*Results:*

```lua
true
false
```

---

#### `some`

```
Llama.Dictionary.some(dictionary, predicate) -> result
```

Returns whether `predicate` returns a truthy for ***any*** of `dictionary`'s entries.

`predicate` is expected to have the following signature:

```
predicate(value, key) -> result
```

*Example:*

```lua
local a = {
	bar1 = "bar",
	bar2 = "bar",
}

local b = {
	foo = "foo",
	bar = "bar",
	baz = "baz",
}

local function onlyFoo(value)
	return value == "foo"
end

Llama.Dictionary.some(a, onlyFoo)
Llama.Dictionary.every(b, onlyFoo)
```

*Results:*

```lua
false
true
```

---

### Combination

#### `flatten`

```
Llama.Dictionary.flatten(dictionary[, depth]) -> dictionary
```

Returns a new dictionary with `dictionary`'s entries flattened to `depth` or as deeply as possible if `depth` is not provided.

*Example:*

```lua
local dictionary = {
	foo = "foo",
	foobar = {
		bar = "bar",
		barbaz = {
			baz = "baz",
		}
	}
}

Llama.Dictionary.flatten(dictionary)
```

*Results:*

```lua
{
	foo = "foo",
	bar = "bar",
	baz = "baz",
}
```

---

## List

Lists are tables with index-value pairs.

### Constructors

#### `create`

```
Llama.List.create(count, value) -> list
```

Creates a new list of `count` `value`s.

---

### Copying

#### `copy`

```
Llama.List.copy(list) -> list
```

Returns a shallow copy of `list`.

---

#### `copyDeep`

```
Llama.List.copyDeep(list) -> list
```

Returns a deep copy of `list`.

!!! warning
	Deep copying is more expensive than shallow copying and forces you to resort to the more expensive `equalsDeep` for value equality checking. Only use it when absolutely necessary.

---

### Comparing

#### `equals`

```
Llama.List.equals(...lists) -> result
```

Returns whether all `lists` have shallow value equality.

---

#### `equalsDeep`

```
Llama.List.equalsDeep(...lists) -> result
```

Returns whether all `lists` have deep value equality.

!!! warning
	Deep comparison is more expensive than shallow comparison. Only use it when absolutely necessary.

---

### Persistent changes

#### `concat`

```
Llama.List.concat(...lists) -> list
```

Returns a concatenation of all of the lists in `lists`.

|Aliases    |
|:---------:|
|`join`     |

*Example:*

```lua
local a = { 1, 2, 3 }
local b = { 4, 5, 6 }

Llama.List.concat(a, b)
```

*Results:*

```lua
{ 1, 2, 3, 4, 5, 6 }
```

---

#### `concatDeep`

```
Llama.List.concatDeep(...lists) -> list
```

Returns a concatenation of all of the lists in `lists` with their sublists deep copied.

|Aliases    |
|:---------:|
|`joinDeep` |

!!! warning
	Deep concatenating is more expensive than shallow concatenating and forces you to resort to the more expensive `equalsDeep` for value equality checking. Only use it when absolutely necessary.

---

#### `insert`

```
Llama.List.insert(list, index, ...values) -> list
```

Returns a new list with `values` inserted at `index` of `list`. If `index` is 0 or negative, `insert` inserts at `index` relative to the end of `list`.

---

#### `push`

```
Llama.List.push(list, ...values) -> list
```

Returns copy of `list` with `values` appended to the end of `list`.

|Aliases    |
|:---------:|
|`append`   |

---

#### `pop`

```
Llama.List.pop(list[, numPops]) -> list
```

Returns copy of `list` with `numPops` values popped off the end of `list`.

---

#### `removeIndex`

```
Llama.List.removeIndex(list, index) -> list
```

Returns a new list where the entry in `list` at `index` is removed. If `index` is 0 or negative, `removeIndex` removes at `index` relative to the end of `list`. 

---

#### `removeIndices`

```
Llama.List.removeIndices(list, ...indices) -> list
```

Returns a new list where all entries in `list` at `indices` is removed. If an index is 0 or negative, `removeIndex` removes at the index relative to the end of `list`.

---

#### `removeValue`

```
Llama.List.removeValue(list, value) -> list
```

Returns a new list with all entries of `list` with `value` removed.

---

#### `removeValues`

```
Llama.List.removeValues(list, ...values) -> list
```

Returns a new list with all entries of `list` with any `values` removed.

---

#### `set`

```
Llama.List.set(list, index, value) -> list
```

Returns a new list with `index` in `list` set to the `value`. If `index` is 0 or negative, `set` sets at `index` relative to the end of `list`.

---

#### `shift`

```
Llama.List.shift(list[, numPlaces]) -> list
```

Returns new list with `numPlaces` values shifted off the beginning of `list`.

*Example:*

```lua
local list = { "foo", "bar", "baz" }

Llama.List.shift(list)
```

*Results:*

```lua
{ "bar", "baz" }
```

---

#### `unshift`

```
Llama.List.unshift(list, ...values) -> list
```

Returns new list with `values` prepended to the beginning of `list`.

*Example:*

```lua
local list = { "baz" }

Llama.List.unshift(list, "foo", "bar")
```

*Results:*

```lua
{ "foo", "bar", "baz" }
```

---

#### `update`

```
Llama.List.update(list, index[, updater[, callback]]) -> list
```

Returns a new list with the entry at `index` being updated by `updater`. If the entry does not exist, `callback` is invoked and the entry is created from its return value.

`updater` and `callback` are expected to have the following signatures:

```
updater(value, index) -> value
callback(index) -> value
```

*Example:*

```lua
local list = { "foo", "bar" }

local function fooify(value)
	return "foo" .. value
end

Llama.List.update(list, 2, fooify)
Llama.List.update(list, 3, fooify, function()
	return "baz"
end)
```

*Results:*

```lua
{ "foo", "foobar" }

{ "foo", "bar", "baz" }
```

---

### Sequence algorithms

#### `filter`

```
Llama.List.filter(list, filterer) -> list
```

Returns a new list with only the entries of `list` for which `filterer` returns a truthy.

`filterer` is expected to have the following signature:

```
filterer(value, index) -> result
```

*Example:*

```lua
local list = { "foo", "foo", "bar" }

local function onlyFoo(value)
	return value == "foo"
end

Llama.List.filter(list, onlyFoo)
```

*Results:*

```lua
{ "foo", "foo" }
```

---

#### `map`

```
Llama.List.map(list, mapper) -> list
```

Returns a new list with the values of `list` mapped over using `mapper`.

`mapper` is expected to have the following signature:

```
mapper(value, index) -> value
```

*Example:*

```lua
local list = { "foo", "bar", "baz" }

local function fooify(value)
	return "foo" .. value
end

Llama.List.map(list, fooify)
```

*Results:*

```lua
{ "foofoo", "foobar", "foobaz" }
```

---

#### `reverse`

```
Llama.List.reverse(list) -> list
```

Returns a new list with the entries of `list` reversed.

*Example:*

```lua
local list = { 1, 2, 3 }

Llama.List.reverse(list)
```

*Results:*

```lua
{ 3, 2, 1 }
```

---

#### `sort`

```
Llama.list.sort(list[, comparator]) -> list
```

Returns a new list with the entries of `list` sorted by `comparator` if given. `comparator` should return `true` if the first argument should come before the second, and `false` otherwise.

`comparator` is expected to have the following signature:

```
comparator(a, b) -> result
```

---

#### `zip`

```
Llama.list.zip(...lists) -> list
```

Returns a new list of `lists` "zipped" together. The length of `list` is the length of the shortest provided list.

*Example:*

```lua
local a = { "foo", "bar", "baz" }
local b = { 1, 2, 3, 4 }

Llama.List.zip(a, b)
```

*Results:*

```lua
{
	{ "foo", 1 },
	{ "bar", 2 },
	{ "baz", 3 },
}
```

---

#### `zipAll`

```
Llama.list.zipAll(...lists) -> list
```

Returns a new list of `lists` "zipped" together. `zipAll` zips as much as possible, filling in `nil` values with [`Llama.None`](api-reference.md#none)

*Example:*

```lua
local a = { "foo", "bar", "baz" }
local b = { 1, 2, 3, 4 }

Llama.List.zipAll(a, b)
```

*Results:*

```lua
{
	{ "foo", 1 },
	{ "bar", 2 },
	{ "baz", 3 },
	{ Llama.None, 4 },
}
```

---

### Creating subsets

#### `slice`

```
Llama.List.slice(list[, from[, to]]) -> list
```

Returns a new list sliced from `list`. If `from` is not provided, `slice` slices from the beginning of `list`. If `to` is not provided, `slice` slices to the end of `list`.

*Example:*

```lua
local list = { 1, 2, 3, 4, 5 }

Llama.List.slice(list, 1, 3)
```

```lua
{ 1, 2, 3 }
```

---

### Reading values

#### `first`

```
Llama.List.first(list) -> result
```

Returns the first value in `list`.

---

#### `last`

```
Llama.List.last(list) -> result
```

Returns the last value in `list`.

---

#### `includes`

```
Llama.List.includes(list, value) -> result
```

Returns whether `list` includes a `value`.

---

### Finding a value

#### `find`

```
Llama.List.find(list, value[, from]) -> index
```

Returns the first index from `from` if provided for which `list` has `value`. If `from` is 0 or negative, `find` searches from `from` relative to the end of `list`.

---

#### `findLast`

```
Llama.List.findLast(list, value[, from]) -> index
```

Returns the last index from `from` if provided for which `list` has `value`. If `from` is 0 or negative, `findLast` searches from `from` relative to the end of `list`.

---

#### `findWhere`

```
Llama.List.findWhere(list, predicate[, from]) -> index
```

Returns the first index from `from` if provided for which `list`'s value satisfies `predicate`. If `from` is 0 or negative, `findWhere` searches from `from` relative to the end of `list`.

`predicate` is expected to have the following signature:

```
predicate(value, index) -> result
```

---

#### `findWhereLast`

```
Llama.List.findWhereLast(list, predicate[, from]) -> index
```

Returns the last index from `from` if provided for which `list`'s value satisfies `predicate`. If `from` is 0 or negative, `findWhereLast` searches from `from` relative to the end of `list`.

`predicate` is expected to have the following signature:

```
predicate(value, index) -> result
```

---

### Conversion

#### `toSet`

```
Llama.List.toSet(list) -> list
```

Returns a new set created from `list`.

---

### Reducing

#### `count`

```
Llama.List.count(list[, predicate]) -> result
```

Returns the number of entries in `list` for which `predicate` returns a truthy. If no predicate is provided, `count` simply counts all of the entries in `list`.

`predicate` is expected to have the following signature:

```
predicate(value, index) -> result
```

*Example:*

```lua
local list = { "foo", "foo", "bar" }

local function onlyFoo(value)
	return value == "foo"
end

Llama.List.count(list, onlyFoo)
```

*Results:*

```lua
2
```

---

#### `every`

```
Llama.List.every(list, predicate) -> result
```

Returns whether `predicate` returns a truthy for ***all*** of `list`'s entries.

`predicate` is expected to have the following signature:

```
predicate(value, index) -> result
```

*Example:*

```lua
local a = { "foo", "foo" }
local b = { "foo", "foo", "bar" }

local function onlyFoo(value)
	return value == "foo"
end

Llama.List.every(a, onlyFoo)
Llama.List.every(b, onlyFoo)
```

*Results:*

```lua
true
false
```

---

#### `some`

```
Llama.List.some(list, predicate) -> result
```

Returns whether `predicate` returns a truthy for ***any*** of `list`'s entries.

`predicate` is expected to have the following signature:

```
predicate(value, key) -> result
```

*Example:*

```lua
local a = { "bar", "bar" }
local b = { "foo", "bar", "baz" }

local function onlyFoo(value)
	return value == "foo"
end

Llama.List.some(a, onlyFoo)
Llama.List.some(b, onlyFoo)
```

*Results:*

```lua
false
true
```

---

#### `reduce`

```
Llama.List.reduce(list, reducer[, initialReduction]) -> value
```

Reduces `list` to a single value, from left to right. If `initialReduction` is not provided, `reduce` uses the first value in `list`.

`reducer` is expected to have the following signature:

```
reducer(reduction, value, key) -> reduction
```

*Example:*

```lua
local list = { 1, 2, 3 }

local function add(reduction, value)
	return reduction = reduction + value
end

Llama.List.reduce(list, add)
```

*Results:*

```lua
6
```

---

#### `reduceRight`

```
Llama.List.reduceRight(list, reducer[, initialReduction]) -> value
```

Reduces `list` to a single value, from right to left. If `initialReduction` is not provided, `reduceRight` uses the last value in `list`.

`reducer` is expected to have the following signature:

```
reducer(reduction, value, key) -> reduction
```

*Example:*

```lua
local list = { 1, 2, 3 }

local function subtract(reduction, value)
	return reduction = reduction - value
end

Llama.List.reduceRight(list, subtract)
```

*Results:*

```lua
0
```

---

### Combination

#### `flatten`

```
Llama.List.flatten(list[, depth]) -> list
```

Returns a new list with all of `list`'s entries flattened to `depth` or as deeply as possible if `depth` is not provided.

*Example:*

```lua
local list = {
	"foo",
	{
		"bar",
		{
			"baz",
		}
	}
}

Llama.List.flatten(list)
```

*Results:*

```lua
{ "foo", "bar", "baz" }
```

---

#### `splice`

```
Llama.List.splice(list, from, to, ...values) -> list
```

Returns a new list with `values` replacing the values between `from` and `to` in `list`.

*Example:*

```lua
local list = { "foo", 2, 3}

Llama.List.splice(list, 2, 3, "bar", "baz")
```

*Results:*

```lua
{ "foo", "bar", "baz" }
```

---

## Set

Sets are tables where each value may only occur once.

### Constructors

#### `fromList`

```
Llama.Set.fromList(list) -> set
```

Creates a set from `list`.

*Example:*

```lua
local list = { "foo", "bar", "baz" }

Llama.Set.fromList(list)
```

*Results:*

```lua
{
	foo = true,
	bar = true,
	baz = true,
}
```

---

### Copying

#### `copy`

```
Llama.Set.copy(set) -> set
```

Returns a shallow copy of `set`.

---

### Comparing

#### `isSubset`

```
Llama.Set.isSubset(subset, superset) -> result
```

Returns whether `subset` is a subset of `superset`.

*Example:*

```lua
local a = {
	foo = true,
	bar = true,
}

local b = {
	foo = true,
	bar = true,
	baz = true,
}

Llama.Set.isSubset(a, b)
Llama.Set.isSubset(b, a)
```

*Results:*

```lua
true
false
```

---

#### `isSuperset`

```
Llama.Set.isSuperset(superset, subset) -> result
```

Returns whether `superset` is a superset of `subset`.

*Example:*

```lua
local a = {
	foo = true,
	bar = true,
	baz = true,
}

local b = {
	foo = true,
	bar = true,
}

Llama.Set.isSuperset(a, b)
Llama.Set.isSuperset(b, a)
```

*Results:*

```lua
true
false
```

---

### Persistent changes

#### `add`

```
Llama.Set.add(set, ...values) -> set
```

Returns a new set with `values` added to `set`.

*Example:*

```lua
local set = {
	foo = true,
	bar = true,
}

Llama.Set.add(set, "baz")
```

*Results:*

```lua
{
	foo = true,
	bar = true,
	baz = true,
}
```

---

#### `subtract`

```
Llama.Set.subtract(set, ...values) -> set
```

Returns a new set with `values` subtracted from `set`.

*Example:*

```lua
local set = {
	foo = true,
	bar = true,
	baz = true,
}

Llama.Set.subtract(set, "baz")
```

*Results:*

```lua
{
	foo = true,
	bar = true,
}
```

---

#### `union`

```
Llama.Set.union(...sets) -> set
```

Returns a new set with all of the values of `sets` combined.

*Example:*

```lua
local a = {
	foo = true,
	bar = true,
}

local b = {
	bar = true,
	baz = true,
}

Llama.Set.union(a, b)
```

*Results:*

```lua
{
	foo = true,
	bar = true,
	baz = true,
}
```

---

#### `intersection`

```
Llama.Set.intersection(...sets) -> set
```

Returns a new set with only the values of `sets` that intersect.

*Example:*

```lua
local a = {
	foo = true,
	bar = true,
}

local b = {
	bar = true,
	baz = true,
}

Llama.Set.intersection(a, b)
```

*Results:*

```lua
{
	bar = true,
}
```

---

### Sequence algorithms

#### `filter`

```
Llama.Set.filter(set, filterer) -> set
```

Returns a new set with only the entries of the set for which the filterer returns a truthy.

`filterer` is expected to have the following signature:

```
filterer(value) -> result
```

*Example:*

```lua
local set = {
	[1] = true,
	[2] = true,
	[3] = true,
	[4] = true,
	[5] = true,
}

local function onlyEvens(value)
	return value % 2 == 0
end

Llama.Set.filter(set, onlyEvens)
```

*Results:*

```lua
{
	[2] = true,
	[4] = true,
}
```

---

#### `map`

```
Llama.Set.map(set, mapper) -> set
```

Returns a new set with the values (and keys) of `dictionary` mapped using the mapper.

`mapper` is expected to have the following signature:

```
mapper(value) -> value
```

*Example:*

```lua
local set = {
	foo = true,
	bar = true,
	baz = true,
}

local function fooify(value)
	return "foo" .. value
end

Llama.Set.map(set, fooify)
```

*Results:*

```lua
{
	foofoo = true,
	foobar = true,
	foobaz = true,
}
```

---

### Reading values

#### `has`

```
Llama.Set.has(set, value) -> result
```

Returns whether `set` has `value`.

---

## `equalObjects`

```
Llama.equalObjects(...objects) -> result
```

Returns whether the items have reference equality.

---

## `isEmpty`

```
Llama.isEmpty(table) -> result
```

Returns whether the table is empty.

---
