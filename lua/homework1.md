---
layout: default
title: Programming in Lua - Homework 1
relpath: ..
---

Programming in Lua - Homework 1
===============================

Feel free to run the following chunks in the interpreter, but it is
better if you try to guess first what the output will be, from what
you have learned in class.

1\. What is the output of the following chunk, and why?

{% highlight lua %}
if nil then print ("true") else print ("false") end
if 0 then print ("true") else print ("false") end
if "" then print ("true") else print ("false") end
if false then print ("true") else print ("false") end
{% endhighlight %}

Answers:

{% highlight lua %}
false
true
true
false
{% endhighlight %}

Because only `nil` and `false` are false in Lua, everything else is true.

2\. What is the output of the following chunk, and why?

{% highlight lua %}
a = 1
print(type(a))
a = print
print(type(a))
a("hello world!")
{% endhighlight %}

Answer:

{% highlight lua %}
number
function
hello world!
{% endhighlight %}

First `a` is a number, then we assign the value of the `print` function to it, 
which is a function. Then we call `a`, which actually calls the `print` function.

3\. What is the output of the following chunk, and why?

{% highlight lua %}
function f()
  i = 10
end

function g()
  local i = 5
end

print(i)
f()
print(i)
g()
print(i)
{% endhighlight %}

Answer:

{% highlight lua %}
nil
10
10
{% endhighlight %}

In the first `print` the variable `i` does not exist, so its value is `nil`,
then `f` assigns to `10` to the global variable `i`, and this is what the second
`print` prints. Function `g` assigns `5` to a *local* variable `i` that is shadowing
the global `i`, so the global `i` is unaffected, and the last `print` still prints `10`.

4\. Write a chunk that counts odd numbers backwards from 99 to 1 
(99, 97, 95, ..., 5, 3, 1), printing each number and them printing their sum.
Do it in three ways: with a while loop, with a repeat loop, and using the numeric for.

Answers:

{% highlight lua %}
local i = 99
local s = 0
while i > 0 do
  print(i)
  s = s + i
  print(s)
  i = i - 2
end
{% endhighlight %}

{% highlight lua %}
local i = 99
local s = 0
repeat
  print(i)
  s = s + i
  print(s)
  i = i - 2
until i == 0
{% endhighlight %}

{% highlight lua %}
local s = 0
for i = 99, 1, -2 do
  print(i)
  s = s + i
  print(s)
end
{% endhighlight %}

5\. Write a function `quadratic(a, b, c)` that returns the two solutions
of the quadratic equation with coeficients `a`, `b`, and `c`. Use
the [quadratic formula](http://0.tqn.com/d/create/1/0/i/9/9/-/Quadratic.formula.jpg).
You can take the square root of a number in Lua with the `math.sqrt` function.
Do not worry about the case where the input to the square root is negative.

{% highlight lua %}
function quadratic(a, b, c)
  local sqr_delta = math.sqrt(b * b - 4 * a * c)
  local two_a = 2 * a
  return (-b + sqr_delta)/two_a, (-b - sqr_delta)/two_a
end
{% endhighlight %}

