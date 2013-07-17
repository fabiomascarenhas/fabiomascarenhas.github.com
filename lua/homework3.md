---
layout: default
title: Programming in Lua - Homework 3
relpath: ..
---

Programming in Lua - Homework 3
===============================

1\. Is there any value *v* that makes `pcall(pcall, v)` return
`false` as its status?

Answer: No. `pcall(v)` can never throw an error, no matter what `v` is.
It will just return `false` plus the error message. So `pcall(pcall, v)` 
succeeds and returns `true` followed by the results of `pcall(v)`.

2\. Define a metamethod `__mul` that for complex numbers that multiplies
two complex numbers (or a complex number and a real).

Answer:

{% highlight lua %}
function mt.__mul(c1, c2)
  if not is_complex(c1) then
    return new(c1 * c2.real, c1 * c2.im)
  elseif not is_complex(c2) then
    return new(c1.real * c2, c1.im * c2)
  else
    return new(c1.real * c2.real - c1.im * c2.im,
               c1.real * c2.im + c1.im * c2.real)
  end
end
{% endhighlight %}

3\. In the presence of metamethods, does `a == b` implies `b == a`? If not,
show as a counter-example an implementation of `__eq` where this does not hold.

Answer: No. One possible way:

{% highlight lua %}
function mt.__eq(a, b)
  return tostring(a) < tostring(b)
end
{% endhighlight %}

4\. Take the implementation of the `Square` class and make it extend the
`Shape` class in the same way that `Circle` does.

Answer:

{% highlight lua %}
local Shape = require "shape"
local Square = setmetatable({}, Shape)
Square.__index = Square

function Square:new(x, y, side)
  local s = Shape.new(self, x, y)
  s.side = side
  return s
end

function Square:area()
  return self.side * self.side
end

function Square:tostring()
  return Shape.tostring(self) .. ", side: " ..
    tostring(self.side)
end

return Square
{% endhighlight %}

5\. Write a `Stack` class that implements a stack, with methods
`push`, `pop`, `peek` (to get the top without popping it) and `isempty`.

{% highlight lua %}
local Stack = {}
Stack.__index = Stack

function Stack:new()
  return setmetatable({}, self)
end

function Stack:push(v)
  self[#self+1] = v
end

function Stack:pop()
  local v = self[#self]
  self[#self] = nil
  return v
end

function Stack:peek()
  return self[#self]
end

function Stack:isempty()
  return #self == 0
end

return Stack
{% endhighlight %}

