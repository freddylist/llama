# Home

Welcome to the Llama documentation!

Llama stands for **Lua Library for Immutable Data**, and it has a ton of utilities for working with Lua tables without mutating them. It's a very simple library, so there isn't much else to say about it!

## Why immutability is important

At first glance, immutability may seem like extra work in return for nothing, but immutability can seriously shrink your code complexity! In any application with state, mutations to the state are not immediately apparent, which <strike>can</strike> will cause bugs later on during development.

Immutability is very good for tracking change to the state by making use of reference equality. If the current state is not the same object as the previous state, then you know that the state has changed, and can react accordingly! With this, immutability has an added bonus of being able to keep a "history" of state changes, which lets you do all sorts of cool things such as backtracking state (useful in hunting for bugs). In comparison, tracking mutable state changes is a nightmare!