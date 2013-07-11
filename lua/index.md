---
layout: default
title: Programming in Lua
relpath: ..
---

Programming in Lua
==================

Overview
--------

Large applications often embed a scripting language as a way to increase their flexibility.
Programmers can use a scripting language for writing configuration files, for coordinating
and controlling components, or for extending the functionality of an application at runtime.
Lua is a scripting language designed to be simple, portable, to have a small footprint,
and to be very easy to embed. Lua is best known as the most commonly used language for
scripting games, but has found use in applications as diverse as Cisco routers, Adobe Photoshop
Lightroom, intrusion detection tools, and set­top boxes for digital television. Lua is also an
expressive, multi­paradigm language that programmers can use to write full applications.
In this course, you will learn how to program in the Lua language and how to embed Lua in
C applications. You will also learn how the Lua virtual machine works, and how the design
of the language is reflected in the engineering of its implementation.

Books and Resources
-------------------

If you are on Windows, you can get the Lua interpreter (an executable,
a DLL, and a library for linking C code with Lua) [here](lua52_win32.zip).
Just unpack it and call `lua.exe` in the command prompt.

The main textbook for this course is [Programming in Lua, third edition](http://store.feistyduck.com/products/programming-in-lua), which
covers Lua 5.2. Most of what we will be covering in this class is also compatible with
Lua 5.1, so students using the second edition of *Programming in Lua* should have
few issues. Even the [first edition](http://www.lua.org/pil/contents.html) of the book,
covering Lua 5.0, is mostly valid. 

The [reference manual](http://http://www.lua.org/manual/5.2/manual.html) for Lua 5.2 is
also an important resource when doing the programming exercises. Consulting the manual
is the best way to find out how a built-in function works.

For the parts of the course that cover the implementation of Lua, the authoritative source
is the Lua source code itself, but there is some documentation that can help: [The Implementation
of Lua 5.0](http://www.lua.org/doc/jucs05.pdf), a paper that describes implentation details of the
 Lua 5.0 virtual machine, most
of which are still applicable to Lua 5.2, and [A No-Frills Introduction the Lua 5.1 VM Instructions](http://luaforge.net/docman/83/98/ANoFrillsIntroToLua51VMInstructions.pdf),
a comprehensive reference of the virtual machine instructions for Lua 5.1, most of which are
unchanged in Lua 5.2.

Lecture Notes
-------------

Lecture notes for the classes will be posted here, after each class:

* [Introduction to Lua](00Introduction.pdf)
* [Getting Started](01GettingStarted.pdf)
* [Types and Values](02Types.pdf)
* [Control Flow](03ControlFlow.pdf)
* [Functions](04Functions.pdf)
* [Data Structures](05DataStructures.pdf)
* [More Functions](06MoreFunctions.pdf)
* [Iterators](07Iterators.pdf)

You can also download the Lua source files for each class:

* [Code for class 1](class1.zip)
* [Code for class 2](class2.zip)
* [Code for class 3](class3.zip)
* [Code for class 4](class4.zip)

Homework
--------

I will not grade the homework, but doing it is recommended, as it is good
preparation for the final exam.

* [Homework 1](homework1.html)
* [Homework 2](homework2.html)

Contact
-------

If you have any questions about the course, please contact me at [my email](mailto:mascarenhas@ufrj.br).

* * * * *

Last update: {{ site.time | date: "%Y-%m-%d %H:%M" }}
