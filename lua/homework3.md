---
layout: default
title: Programming in Lua - Homework 3
relpath: ..
---

Programming in Lua - Homework 3
===============================

1\. Is there any value *v* that makes `pcall(pcall, v)` return
`false` as its status?

2\. Define a metamethod `__mul` that for complex numbers that multiplies
two complex numbers (or a complex number and a real).

3\. In the presence of metamethods, does `a == b` implies `b == a`? If not,
show as a counter-example an implementation of `__eq` where this does not hold.

4\. Take the implementation of the `Square` class and make it extend the
`Shape` class in the same way that `Circle` does.

5\. Write a `Stack` class that implements a stack, with methods
`push`, `pop`, `peek` (to get the top without popping it) and `isempty`.
