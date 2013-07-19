---
layout: default
title: Programming in Lua - Exam
relpath: ..
---

Programming in Lua Exam
-----------------------

1\. (6 points) Show how to write the following piece of XML as
a short string and as a long string:

{% highlight xml %}
<![CDATA[
  Hello World
]]>
{% endhighlight %}
    
Answer:

{% highlight lua %}
"<![CDATA[\n  Hello World\n]]>"

[=[<![CDATA[
  Hello World
]]>]=]
{% endhighlight %}

2\. (6 points) After running `a = {}; a.a = a`, what is the
value of `a.a.a.a`? If we now do `a.a.a.a = 3`, what is the
value of `a.a.a.a`?

{% highlight lua %}
The same as a.

It is an error, because a.a is now 3.
{% endhighlight %}

3\. (6 points) Write a function that receives an arbitrary number
of values and returns all of them, except the first one.

{% highlight lua %}
function drop1(x, ...)
  return ...
end
{% endhighlight %}

4\. (12 points) Write a function `poly` that takes a polynomial represented
as an array of coeficients and returns a function that takes a
parameter `x` and evaluates the polynomial for `x`. For example:

{% highlight lua %}
f = poly({3, 0, 1})
print(f(0)) -- 1
print(f(5)) -- 76
{% endhighlight %}

Answer:

{% highlight lua %}
function poly(cs)
  return function(x)
           local sum = 0
           local power = #cs - 1
           for _, c in ipairs(cs) do
             sum = sum + c * (x ^ power)
             power = power - 1
           end
           return sum
         end
end
{% endhighlight %}

5\. (15 points) Write a function `fibs` that returns a  *closure iterator*
that produces the first `n` numbers
of the Fibonacci sequence (1, 1, 2, 3, 5, 8, 13, ...). For example:

{% highlight lua %}
s = 0
for i in fibs(5) do
  s = s + i
end
print(s) -- 1 + 1 + 2 + 3 + 5
{% endhighlight %}

Answer:

{% highlight lua %}
function fibs(n)
  local a = 1
  local b = 1
  return function ()
           if n == 0 then return end
           local next = a
           a, b = b, a + b
           n = n - 1
           return next
         end
end
{% endhighlight %}

6\. (6 points) Suppose the value of `package.path` is `.\?.lua;c:\Lua52\libs\?.lua;c:\Lua52\libs\?\init.lua`.
What files will Lua try to load if we do `require "mypack.mymod"`?

{% highlight lua %}
.\mypack\mymod.lua
c:\Lua52\libs\mypack\mymod.lua
c:\Lua52\libs\mypack\mymod\init.lua
{% endhighlight %}

7\. (6 points) Is the operation `==` always commutative in Lua? Explain.

{% highlight lua %}
No, because the __eq metamethod may not implement a commutative operation.
{% endhighlight %}

8\. (15 points) Write an `Iterator` class that takes a *closure iterator*
in its constructor. Objects of the `Iterator` class have a `next` method
that returns the next element produced by the closure iterator.

{% highlight lua %}
local Iterator = {}
Iterator.__index = Iterator

function Iterator:new(iter)
  return setmetatable({ iter = iter }, self)
end

function Iterator:next()
  return self.iter()
end
{% endhighlight %}

9\. (6 points) Assume the Lua stack is empty. What will be its contents after
the following sequences of calls in a C function?

{% highlight c %}
lua_pushstring(L, "foo");
lua_pushnil(L);
lua_pushvalue(L, -2);
lua_pushnumber(L, 5);
lua_remove(L, 1);
lua_insert(L, -2);
{% endhighlight %}

Answer:

{% highlight lua %}
From bottom to top:

nil 5 "foo"
{% endhighlight %}

10\. (10 points) A web server uses a Lua configuration file like the one below.
Assume that the configuration file has already been loaded. Write the C code that
extracts the configuration values from the Lua state, and writes them to variables
`addr_ip`, `addr_port`, and `http_root` on the C side. 

{% highlight lua %}
address = { ip = "*", port = 8080 }
root = "/var/www"
{% endhighlight %}

Answer:

{% highlight lua %}
lua_getglobal(L, "address");
lua_getfield(L, -1, "ip");
strcpy(addr_ip, lua_tostring(L, -1));
lua_pop(L, 1);
lua_getfield(L, -1, "port");
addr_port = lua_tointeger(L, -1);
lua_getglobal(L, "root");
strcpy(http_root, lua_tostring(L, -1));
{% endhighlight %}

11\. (6 points) Write a C function that receives an arbitrary number
of values and returns all of them, except the first one.

{% highlight c %}
static int drop1(lua_State *L) {
  int nargs = lua_gettop(L);
  if(nargs > 0)
    return nargs - 1;
  else
    return 0;
}
{% endhighlight %}

12\. (6 points) Write the Lua code that corresponds to the sequence
of Lua VM instructions below. Assume that register 0 is the local
variable `a`, register 1 is `b`, and register 2 is `c`.

{% highlight lua %}
NEWTABLE R0 R0 R0
SETTABLE R0 R1 R2
GETTABLE R1 R0 R1
{% endhighlight %}

Answer (**void**):

{% highlight lua %}
a = {}
b[c] = a
b = a[b]
{% endhighlight %}
